import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_loading.dart';

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
                ? const CustomLoading(size: 20)
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
