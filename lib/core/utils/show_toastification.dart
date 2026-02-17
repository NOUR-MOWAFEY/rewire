import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

import 'app_colors.dart';

class ShowToastification {
  static ToastificationItem failure(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: Icon(FontAwesomeIcons.circleExclamation, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.red,
      borderSide: BorderSide(color: Colors.red),
      context: context,
      title: Text(text, style: TextStyle(color: AppColors.white)),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static ToastificationItem success(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: Icon(FontAwesomeIcons.circleCheck, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.green,
      borderSide: BorderSide(color: Colors.green),
      context: context,
      title: Text(text, style: TextStyle(color: AppColors.white)),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  static ToastificationItem warning(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: Icon(FontAwesomeIcons.circleExclamation, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.orangeAccent,
      borderSide: BorderSide(color: Colors.orangeAccent),
      context: context,
      title: Text(text, style: TextStyle(color: AppColors.white)),
      autoCloseDuration: const Duration(seconds: 5),
    );
  }
}
