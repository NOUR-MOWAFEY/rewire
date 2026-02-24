import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';

class ProfileCustomTextField extends StatefulWidget {
  const ProfileCustomTextField({
    super.key,
    required this.hintText,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
  });

  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  @override
  State<ProfileCustomTextField> createState() => _ProfileCustomTextFieldState();
}

class _ProfileCustomTextFieldState extends State<ProfileCustomTextField> {
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
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
