import 'package:flutter/material.dart';

String? validator(
  InputType inputType,
  String? value,
  TextEditingController? passwordController,
) {
  if (value == null || value.isEmpty) {
    return 'Requied field';
  } else {
    var text = value.trim();

    switch (inputType) {
      case InputType.email:
        if (!emailRegex.hasMatch(text)) {
          return 'Invalid email';
        }
      case InputType.password:
        if (text.isEmpty) {
          return 'Password cannot be all spaces';
        }
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
      case InputType.name:
        if (text.length < 3) {
          return 'Name is too short';
        }
      case InputType.confirmPassword:
        if (value.isEmpty) return null;
        if (value != passwordController!.text) {
          return 'Passwords do not match';
        }
    }
  }
  return null;
}

final emailRegex = RegExp(r'^[\w\.\-+]+@([\w-]+\.)+[\w-]{2,4}$');

enum InputType { email, password, confirmPassword, name }
