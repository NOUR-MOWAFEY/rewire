import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import 'app_colors.dart';

class ShowToastification {
  static ToastificationItem failure(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: Icon(Icons.warning_rounded, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.red,
      borderSide: BorderSide(color: Colors.red),
      context: context,
      title: Text(text, style: TextStyle(color: AppColors.white)),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  static ToastificationItem success(BuildContext context, String text) {
    return toastification.show(
      alignment: Alignment.topCenter,
      icon: Icon(Icons.check_circle_outline, color: AppColors.white),
      foregroundColor: AppColors.white,
      backgroundColor: Colors.green,
      borderSide: BorderSide(color: Colors.green),
      context: context,
      title: Text(text, style: TextStyle(color: AppColors.white)),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
