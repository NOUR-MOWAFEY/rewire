import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.transparentPrimary,
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(color: AppColors.primary, width: 2),
        ),
        child: Center(child: Text(title, style: AppStyles.textStyle32)),
      ),
    );
  }
}
