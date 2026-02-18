import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';

class ProfileCustomTextField extends StatelessWidget {
  const ProfileCustomTextField({
    super.key,
    required this.hintText,
    this.isEmail = false,
  });
  final String hintText;
  final bool isEmail;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: isEmail ? TextInputAction.done : TextInputAction.next,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
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
