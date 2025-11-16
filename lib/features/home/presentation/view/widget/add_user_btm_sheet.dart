import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task/core/utils/functions.dart';
import '../../../../../core/model/custom_dropdown_item.dart';
import '../../../../../core/utils/size_config.dart';
import '../../../../../core/widget/custom_drop_down.dart';
import '../../../../../core/widget/custom_input_field.dart';
import '../../../../../core/widget/custom_password_input_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/model/user_model.dart';

class AddUserBottomSheet extends StatefulWidget {
  const AddUserBottomSheet({super.key});

  @override
  State<AddUserBottomSheet> createState() => _AddUserBottomSheetState();
}

class _AddUserBottomSheetState extends State<AddUserBottomSheet> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  CustomDropdownItem<String>? _selectedUserType;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  List<CustomDropdownItem<String>> get _userTypes => [
    CustomDropdownItem(id: 'admin', text: S.of(context).admin),
    CustomDropdownItem(id: 'employee', text: S.of(context).employee),
  ];

  bool _validateForm() {
    bool isValid = true;
    final s = S.of(context);

    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
    });

    if (_nameController.text.trim().isEmpty) {
      setState(() => _nameError = s.errorNameRequired);
      isValid = false;
    }

    if (_emailController.text.trim().isEmpty) {
      setState(() => _emailError = s.errorEmailRequired);
      isValid = false;
    } else if (!_isValidEmail(_emailController.text.trim())) {
      setState(() => _emailError = s.errorInvalidEmail);
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = s.errorPasswordRequired);
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() => _passwordError = s.errorPasswordShort);
      isValid = false;
    }

    if (_selectedUserType == null) {
      Functions.showSnackBar(s.errorUserTypeRequired);
      isValid = false;
    }

    return isValid;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void _handleSubmit() {
    if (_validateForm()) {
      final user = UserModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        type: _selectedUserType!.id,
      );
      GoRouter.of(
        context,
      ).pop({"user": user, "password": _passwordController.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.defaultSize * 2),
          topRight: Radius.circular(SizeConfig.defaultSize * 2),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.addNewUser,
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

            CustomInputField(
              label: s.name,
              isRequired: true,
              controller: _nameController,
              hint: s.enterUserName,
              icon: const Icon(Icons.person_outline),
              error: _nameError,
            ),

            SizedBox(height: SizeConfig.defaultSize * 2),

            CustomInputField(
              label: s.email,
              isRequired: true,
              controller: _emailController,
              hint: s.enterEmail,
              icon: const Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              error: _emailError,
            ),

            SizedBox(height: SizeConfig.defaultSize * 2),

            CustomPasswordInputField(
              label: s.password,
              isRequired: true,
              controller: _passwordController,
              hint: s.enterPassword,
              icon: Icons.lock_outline,
              error: _passwordError,
            ),

            SizedBox(height: SizeConfig.defaultSize * 2),

            CustomDropDown<String>(
              label: "${s.userType} *",
              hint: s.selectUserType,
              items: _userTypes,
              onItemSelected: (item) {
                setState(() {
                  _selectedUserType = item;
                });
              },
              isFilled: true,
              fillColor: Theme.of(context).cardColor,
            ),

            SizedBox(height: SizeConfig.defaultSize * 3),

            ElevatedButton(
              onPressed: _handleSubmit,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize * 1.5,
                ),
              ),
              child: Text(
                s.addUser,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: SizeConfig.defaultSize),
          ],
        ),
      ),
    );
  }
}
