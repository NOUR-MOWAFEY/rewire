import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_colors.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparentPrimary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: IconButton(
        onPressed: () {
          context.pop();
        },
        icon: const Icon(FontAwesomeIcons.chevronLeft),
      ),
    );
  }
}
