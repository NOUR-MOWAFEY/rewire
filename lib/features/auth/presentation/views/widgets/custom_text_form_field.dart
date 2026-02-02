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
    required this.inputType,
    this.isLastOne = false,
    this.passwordController,
  });
  final String title;
  final bool isPassword;
  final bool isLastOne;
  final IconData icon;
  final TextEditingController? controller;
  final InputType inputType;
  final TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => validator(inputType, value, passwordController),
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
          padding: const EdgeInsets.only(left: 16, right: 4),
          child: Icon(icon, color: Colors.grey),
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
      borderSide: BorderSide(color: AppColors.primary, width: 2),
    );
  }
}
