import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/validator.dart';

class CustomTextFormField extends StatefulWidget {
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.isEnabled,
      validator: widget.inputType != null
          ? (value) =>
                validator(widget.inputType!, value, widget.passwordController)
          : null,
      autovalidateMode: AutovalidateMode.onUserInteractionIfError,
      controller: widget.controller,
      cursorColor: AppColors.white,
      obscureText: obscureText,
      keyboardType: widget.isPassword
          ? TextInputType.text
          : TextInputType.emailAddress,
      textInputAction: widget.isLastOne
          ? TextInputAction.done
          : TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 2),
          child: Icon(widget.icon, color: Colors.grey, size: 20),
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(
                    !obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                    size: 22,
                  ),
                ),
              )
            : null,
        fillColor: AppColors.transparentPrimary,
        filled: true,
        hintText: widget.title,
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        border: customOutlineInputBorder(),
        enabledBorder: customOutlineInputBorder(),
        focusedBorder: customOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder customOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(32),
      borderSide: widget.border
          ? const BorderSide(color: AppColors.primary, width: 2)
          : const BorderSide(color: Colors.transparent),
    );
  }
}
