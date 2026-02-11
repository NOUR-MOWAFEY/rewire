import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../data/models/habit_model.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({
    super.key,
    required this.habitModel,
    required this.isLastItem,
    required this.isFirstItem,
  });
  final HabitModel habitModel;
  final bool isLastItem;
  final bool isFirstItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isFirstItem ? const SizedBox(height: 30) : const SizedBox(),
        InkWell(
          onTap: () {
            context.push(AppRouter.groupDetailsView);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 170,
            decoration: BoxDecoration(
              color: AppColors.transparentPrimary,
              borderRadius: BorderRadius.circular(16),
              // border: BoxBorder.all(color: AppColors.primary, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habitModel.title,
                  style: AppStyles.textStyle24,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  habitModel.createdAt == null
                      ? ''
                      : DateFormat.yMd().format(habitModel.createdAt!.toDate()),
                  style: AppStyles.textStyle16,
                ),
                const Spacer(),
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
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
        ),
        isLastItem ? const SizedBox(height: 80) : const SizedBox(),
      ],
    );
  }
}
