import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task/core/utils/functions.dart';

import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widget/custom_input_field.dart';
import '../../../../home/data/model/product_model.dart';
import '../../../../../generated/l10n.dart';

class UpdateProductBottomSheet extends StatefulWidget {
  final ProductModel product;

  const UpdateProductBottomSheet({super.key, required this.product});

  @override
  State<UpdateProductBottomSheet> createState() =>
      _UpdateProductBottomSheetState();
}

class _UpdateProductBottomSheetState extends State<UpdateProductBottomSheet> {
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

  XFile? _newImageFile; // Only when user selects a new image
  late String _currentImagePath; // Initial image path

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.product.name;
    _descriptionController.text = widget.product.description;
    _priceController.text = widget.product.price.toString();
    _quantityController.text = widget.product.quantity.toString();

    _currentImagePath = widget.product.imagePath;
  }

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
          _newImageFile = image;
          _imageError = null;
        });
      }
    } catch (e) {
      if (context.mounted) {
        Functions.showSnackBar('${S.of(context).errorPickingImage}: $e');
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (_) {
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

  bool _isNetworkImage(String path) {
    return path.trim().toLowerCase().startsWith('http');
  }

  bool _validateForm() {
    bool isValid = true;

    setState(() {
      _nameError = null;
      _descriptionError = null;
      _priceError = null;
      _quantityError = null;
      _imageError = null;
    });

    if (_nameController.text.trim().isEmpty) {
      _nameError = S.of(context).productNameRequired;
      isValid = false;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _descriptionError = S.of(context).descriptionRequired;
      isValid = false;
    }

    if (_priceController.text.trim().isEmpty) {
      _priceError = S.of(context).priceRequired;
      isValid = false;
    } else {
      final price = double.tryParse(_priceController.text.trim());
      if (price == null || price <= 0) {
        _priceError = S.of(context).enterValidNumber;
        isValid = false;
      }
    }

    if (_quantityController.text.trim().isEmpty) {
      _quantityError = S.of(context).quantityRequired;
      isValid = false;
    } else {
      final qty = int.tryParse(_quantityController.text.trim());
      if (qty == null || qty <= 0) {
        _quantityError = S.of(context).enterValidInteger;
        isValid = false;
      }
    }

    if ((_currentImagePath.isEmpty || _currentImagePath.trim() == '') &&
        _newImageFile == null) {
      _imageError = S.of(context).selectProductImage;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  void _handleSubmit() {
    if (!_validateForm()) return;

    final updatedProduct = ProductModel(
      id: widget.product.id, // IMPORTANT
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      price: double.parse(_priceController.text.trim()),
      quantity: int.parse(_quantityController.text.trim()),
      imagePath: _newImageFile?.path ?? _currentImagePath,
      creator: widget.product.creator,
    );

    GoRouter.of(context).pop(updatedProduct);
  }

  void _clearImage() {
    setState(() {
      _newImageFile = null;
      _currentImagePath = '';
    });
  }

  Widget _buildImageContent() {
    // If user picked a new local image -> show it
    if (_newImageFile != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 1.25),
            child: Image.file(
              File(_newImageFile!.path),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close, size: 18, color: Colors.white),
                onPressed: _clearImage,
              ),
            ),
          ),
        ],
      );
    }

    // If we have a non-empty path and it's a network URL -> use CachedNetworkImage
    if (_currentImagePath.isNotEmpty && _isNetworkImage(_currentImagePath)) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 1.25),
            child: CachedNetworkImage(
              imageUrl: _currentImagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.broken_image, size: 40),
                    SizedBox(height: SizeConfig.defaultSize),
                    Text(S.of(context).imageLoadFailed),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                onPressed: _clearImage,
              ),
            ),
          ),
        ],
      );
    }

    // If we have a non-empty local file path (legacy local path) -> show Image.file
    if (_currentImagePath.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize * 1.25),
            child: Image.file(
              File(_currentImagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              radius: 16,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                onPressed: _clearImage,
              ),
            ),
          ),
        ],
      );
    }

    // No image -> show placeholder
    return Column(
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
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor),
        ),
      ],
    );
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).updateProduct,
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

              // IMAGE
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
                  child: _buildImageContent(),
                ),
              ),
              if (_imageError != null)
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    _imageError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              // FIELDS
              CustomInputField(
                label: S.of(context).productName,
                isRequired: true,
                controller: _nameController,
                hint: S.of(context).enterProductName,
                icon: const Icon(Icons.shopping_bag_outlined),
                error: _nameError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              CustomInputField(
                label: S.of(context).description,
                isRequired: true,
                controller: _descriptionController,
                hint: S.of(context).enterDescription,
                icon: const Icon(Icons.description_outlined),
                error: _descriptionError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              CustomInputField(
                label: S.of(context).price,
                isRequired: true,
                controller: _priceController,
                hint: S.of(context).enterPrice,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                icon: const Icon(Icons.attach_money),
                error: _priceError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 2),

              CustomInputField(
                label: S.of(context).quantity,
                isRequired: true,
                controller: _quantityController,
                hint: S.of(context).enterQuantity,
                keyboardType: TextInputType.number,
                icon: const Icon(Icons.format_list_numbered),
                error: _quantityError,
              ),
              SizedBox(height: SizeConfig.defaultSize * 3),

              // UPDATE BUTTON
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
                  S.of(context).updateProduct,
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
