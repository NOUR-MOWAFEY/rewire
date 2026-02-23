import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';

class ProfileCustomTextField extends StatelessWidget {
  const ProfileCustomTextField({
    super.key,
    required this.hintText,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
     this.isObscure = false,
  });
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      cursorColor: AppColors.white,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
