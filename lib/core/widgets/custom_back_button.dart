import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.color = AppColors.transparentPrimary,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,

      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
      ),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(
          FontAwesomeIcons.chevronLeft,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}
