import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'custom_button.dart';
import 'custom_circular_loading.dart';

class CustomUpdateButton extends StatelessWidget {
  const CustomUpdateButton({
    super.key,
    this.onPressed,
    this.title = 'Update',
    this.isEnabled = true,
    this.isLoading = false,
  });
  final void Function()? onPressed;
  final String? title;
  final bool? isEnabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: AbsorbPointer(
          absorbing: isLoading || !isEnabled!,
          child: CustomButton(
            title: title,
            width: 110,
            height: 40,
            onPressed: onPressed,
            child: isLoading
                ? const CustomCircularLoading(size: 20)
                : Text(
                    title ?? '',
                    style: AppStyles.textStyle16.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
