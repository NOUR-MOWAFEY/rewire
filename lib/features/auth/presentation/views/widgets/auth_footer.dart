import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.text,
    required this.buttonTitle,
    required this.navigateTo,
  });
  final String text;
  final String buttonTitle;
  final String navigateTo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: AppStyles.textStyle16),
        InkWell(
          onTap: () {
            navigateTo == '/'
                ? GoRouter.of(context).go('/')
                : GoRouter.of(context).push(navigateTo);
          },
          child: Text(
            buttonTitle,
            style: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
