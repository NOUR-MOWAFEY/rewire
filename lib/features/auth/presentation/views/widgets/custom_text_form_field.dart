import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/validator.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.isPassword = false,
    required this.icon,
    this.controller,
    this.inputType,
    this.isLastOne = false,
    this.passwordController,
    this.isEnabled = true,
    this.border = true,
  });
  final String title;
  final bool isPassword;
  final bool isLastOne;
  final IconData icon;
  final TextEditingController? controller;
  final InputType? inputType;
  final TextEditingController? passwordController;
  final bool isEnabled;
  final bool border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnabled,
      validator: inputType != null
          ? (value) => validator(inputType!, value, passwordController)
          : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      cursorColor: AppColors.white,
      obscureText: isPassword,
      keyboardType: isPassword
          ? TextInputType.text
          : TextInputType.emailAddress,
      textInputAction: isLastOne ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 2),
          child: Icon(icon, color: Colors.grey, size: 22),
        ),
        fillColor: AppColors.transparentPrimary,
        filled: true,
        hintText: title,
        hintStyle: TextStyle(fontWeight: FontWeight.bold),
        border: customOutlineInputBorder(),
        enabledBorder: customOutlineInputBorder(),
        focusedBorder: customOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: border
          ? BorderSide(color: AppColors.primary, width: 2)
          : BorderSide(color: Colors.transparent),
    );
  }
}
