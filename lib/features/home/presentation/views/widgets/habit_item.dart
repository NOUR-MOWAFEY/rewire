import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/habit_model.dart';

class HabitItem extends StatelessWidget {
  const HabitItem({super.key, required this.habitModel});
  final HabitModel habitModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRouter.groupDetailsView);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.transparentPrimary,
          borderRadius: BorderRadius.circular(16),
          border: BoxBorder.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(habitModel.title, style: AppStyles.textStyle24),
            Text(
              habitModel.createdAt == null
                  ? ''
                  : DateFormat.yMd().format(habitModel.createdAt!.toDate()),
              style: AppStyles.textStyle16,
            ),
            Align(
              alignment: AlignmentGeometry.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Members: ${habitModel.participants.length}',
                  style: AppStyles.textStyle16.copyWith(
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
