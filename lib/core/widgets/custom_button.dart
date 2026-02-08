import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.width = double.infinity,
    this.child,
    this.height = 50,
  });
  final String? title;
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.transparentPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(32),
          ),
        ),
        child:
            child ??
            Text(
              title ?? '',
              style: AppStyles.textStyle16.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}
