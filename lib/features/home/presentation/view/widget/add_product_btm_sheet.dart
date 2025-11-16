import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/core/helpers/shared_pref_helper.dart';
import 'package:task/core/utils/functions.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widget/custom_input_field.dart';
import '../../../data/model/product_model.dart';
import '../../../../../generated/l10n.dart'; // Make sure this path matches your generated localization file

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({super.key});

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String? _nameError;
  String? _descriptionError;
  String? _priceError;
  String? _quantityError;
  String? _imageError;

  XFile? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = image;
          _imageError = null;
        });
      }
    } catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        Functions.showSnackBar('${S.of(context).errorPickingImage}: $e');
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).selectImageSource),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(S.of(context).camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(S.of(context).gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _validateForm() {
    bool isValid = true;

    // Reset errors
    setState(() {
      _nameError = null;
      _descriptionError = null;
      _priceError = null;
      _quantityError = null;
      _imageError = null;
    });

    // Validate name
    if (_nameController.text.trim().isEmpty) {
      setState(() {
        _nameError = S.of(context).productNameRequired;
      });
      isValid = false;
    }

    // Validate description
    if (_descriptionController.text.trim().isEmpty) {
      setState(() {
        _descriptionError = S.of(context).descriptionRequired;
      });
      isValid = false;
    }

    // Validate price
    if (_priceController.text.trim().isEmpty) {
      setState(() {
        _priceError = S.of(context).priceRequired;
      });
      isValid = false;
    } else {
      final price = double.tryParse(_priceController.text.trim());
      if (price == null) {
        setState(() {
          _priceError = S.of(context).enterValidNumber;
        });
        isValid = false;
      } else if (price <= 0) {
        setState(() {
          _priceError = S.of(context).priceGreaterThanZero;
        });
        isValid = false;
      }
    }

    // Validate quantity (integer > 0)
    if (_quantityController.text.trim().isEmpty) {
      setState(() {
        _quantityError = S.of(context).quantityRequired;
      });
      isValid = false;
    } else {
      final qty = int.tryParse(_quantityController.text.trim());
      if (qty == null) {
        setState(() {
          _quantityError = S.of(context).enterValidInteger;
        });
        isValid = false;
      } else if (qty <= 0) {
        setState(() {
          _quantityError = S.of(context).quantityGreaterThanZero;
        });
        isValid = false;
      }
    }

    // Validate image
    if (_selectedImage == null) {
      setState(() {
        _imageError = S.of(context).selectProductImage;
      });
      isValid = false;
    }

    return isValid;
  }

  void _handleSubmit() {
    if (_validateForm()) {
      final product = ProductModel(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        quantity: int.parse(_quantityController.text.trim()),
        imagePath: _selectedImage!.path,
        creator: SharedPrefsHelper.getUserModel()?.name ?? "",
        id: Functions.getCurrentMillisecondsTimeStampUtc().toString(),
      );
      GoRouter.of(context).pop(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(SizeConfig.defaultSize * 2),
        topRight: Radius.circular(SizeConfig.defaultSize * 2),
      ),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).addNewProduct,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // Image Picker Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).productImage,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 1),
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(
                          SizeConfig.defaultSize * 1.25,
                        ),
                        border: Border.all(
                          color: _imageError != null
                              ? Colors.red
                              : Theme.of(context).dividerColor,
                        ),
                      ),
                      child: _selectedImage != null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    SizeConfig.defaultSize * 1.25,
                                  ),
                                  child: Image.file(
                                    File(_selectedImage!.path),
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 16,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selectedImage = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 50,
                                  color: Theme.of(context).hintColor,
                                ),
                                SizedBox(height: SizeConfig.defaultSize),
                                Text(
                                  S.of(context).tapToSelectImage,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  if (_imageError != null)
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeConfig.defaultSize * 0.5,
                        left: SizeConfig.defaultSize * 1.5,
                      ),
                      child: Text(
                        _imageError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                ],
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // Name Field
              CustomInputField(
                label: S.of(context).productName,
                isRequired: true,
                controller: _nameController,
                hint: S.of(context).enterProductName,
                icon: const Icon(Icons.shopping_bag_outlined),
                error: _nameError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // Description Field
              CustomInputField(
                label: S.of(context).description,
                isRequired: true,
                controller: _descriptionController,
                hint: S.of(context).enterDescription,
                icon: const Icon(Icons.description_outlined),
                error: _descriptionError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // Price Field
              CustomInputField(
                label: S.of(context).price,
                isRequired: true,
                controller: _priceController,
                hint: S.of(context).enterPrice,
                icon: const Icon(Icons.attach_money),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                error: _priceError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // Quantity Field
              CustomInputField(
                label: S.of(context).quantity,
                isRequired: true,
                controller: _quantityController,
                hint: S.of(context).enterQuantity,
                icon: const Icon(Icons.format_list_numbered),
                keyboardType: TextInputType.number,
                error: _quantityError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 3),

              // Submit Button
              ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.defaultSize * 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      SizeConfig.defaultSize * 1.25,
                    ),
                  ),
                ),
                child: Text(
                  S.of(context).addProduct,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.defaultSize * 3),
            ],
          ),
        ),
      ),
    );
  }
}
