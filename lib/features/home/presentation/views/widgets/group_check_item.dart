import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';

class GroupCheckItem extends StatelessWidget {
  const GroupCheckItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 85,
      width: 80,
      decoration: BoxDecoration(
        color: AppColors.transparentPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(FontAwesomeIcons.circleCheck, size: 38),
          VerticalDivider(
            color: AppColors.secondary,
            indent: 10,
            endIndent: 10,
          ),
          Icon(FontAwesomeIcons.circleCheck, size: 38),
          VerticalDivider(
            color: AppColors.secondary,
            indent: 10,
            endIndent: 10,
          ),
          Icon(FontAwesomeIcons.circleCheck, size: 38),
          VerticalDivider(
            color: AppColors.secondary,
            indent: 10,
            endIndent: 10,
          ),
          Icon(FontAwesomeIcons.circleCheck, size: 38),
          VerticalDivider(
            color: AppColors.secondary,
            indent: 10,
            endIndent: 10,
          ),
          Icon(FontAwesomeIcons.circleCheck, size: 38),
        ],
      ),
    );
  }
}
