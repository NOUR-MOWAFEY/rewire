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
      pauseOnHover: true,
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
      pauseOnHover: true,
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
      pauseOnHover: true,
    );
  }

  static ToastificationItem popUp(BuildContext context, String text) {
    return toastification.show(
      closeOnClick: true,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      padding: EdgeInsets.only(left: 14, right: 10, top: 8, bottom: 8),
      style: ToastificationStyle.simple,
      alignment: Alignment.bottomCenter,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primary,
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(32),
      context: context,
      title: Text(
        text,
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      ),
      autoCloseDuration: const Duration(seconds: 2),
      pauseOnHover: true,
      applyBlurEffect: true,
    );
  }
}
