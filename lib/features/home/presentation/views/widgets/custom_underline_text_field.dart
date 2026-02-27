import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/validator.dart';

class CustomUnderlineTextField extends StatefulWidget {
  const CustomUnderlineTextField({
    super.key,
    required this.hintText,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.controller,
    this.inputType = InputType.name,
  });

  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final InputType inputType;

  @override
  State<CustomUnderlineTextField> createState() =>
      _CustomUnderlineTextFieldState();
}

class _CustomUnderlineTextFieldState extends State<CustomUnderlineTextField> {
  late bool _isObscure;
  late IconData _icon;

  @override
  void initState() {
    super.initState();
    _isObscure = true;
    _icon = FontAwesomeIcons.eyeSlash;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      validator: (value) => validator(widget.inputType, value, null),

      autovalidateMode: .onUserInteractionIfError,

      obscureText: widget.textInputType == TextInputType.visiblePassword
          ? _isObscure
          : false,

      textInputAction: widget.textInputAction,

      keyboardType: widget.textInputType,

      cursorColor: AppColors.white,

      cursorWidth: 1,

      decoration: InputDecoration(
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscure = !_isObscure;
                    _icon = _isObscure == true
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye;
                  });
                },
                child: Icon(_icon, size: 20),
              )
            : null,

        hintText: widget.hintText,
        border: customUnderlineInputBorder(),
        focusedBorder: customUnderlineInputBorder(),
      ),
    );
  }

  UnderlineInputBorder customUnderlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.primary),
    );
  }
}
