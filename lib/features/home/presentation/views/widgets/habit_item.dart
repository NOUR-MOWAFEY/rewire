import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/habit_model.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({super.key, required this.habitModel});
  final HabitModel habitModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.transparentPrimary,
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(habitModel.title, style: AppStyles.textStyle32),
            Text(
              DateFormat.yMd().format(habitModel.createdAt!.toDate()),
              style: AppStyles.textStyle18,
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Members: 2',
                  style: AppStyles.textStyle18.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
