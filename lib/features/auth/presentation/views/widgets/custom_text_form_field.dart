import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.isPassword = false,
    required this.icon,
  });
  final String title;
  final bool isPassword;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.white,
      obscureText: isPassword,
      keyboardType: isPassword
          ? TextInputType.text
          : TextInputType.emailAddress,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
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
