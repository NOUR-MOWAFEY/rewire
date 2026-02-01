import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          backgroundColor: AppColors.transparentPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(32),
          ),
        ),
        child: Text(
          title,
          style: AppStyles.textStyle16.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
