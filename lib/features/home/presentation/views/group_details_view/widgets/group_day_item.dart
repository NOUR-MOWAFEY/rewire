import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/check_icon_button.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class GroupDayItem extends StatelessWidget {
  const GroupDayItem({
    super.key,
    required this.date,
    required this.dayCheckins,
  });

  final String date;
  final List<CheckInModel> dayCheckins;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthCubit>().getUser()!.uid;

    final sortedCheckins = List<CheckInModel>.from(dayCheckins);

    sortedCheckins.sort((a, b) {
      if (a.userId == currentUserId) return -1;
      if (b.userId == currentUserId) return 1;
      return 0;
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 4),
          child: Text(date, style: AppStyles.textStyle14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          height: 85,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.transparentPrimary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: .horizontal,

                itemBuilder: (context, index) {
                  final checkIn = sortedCheckins[index];

                  return CheckIconButton(
                    checkIn: checkIn,
                    isCurrentUser: checkIn.userId == currentUserId,
                    isTodayItem: context.read<DaysCubit>().today == date,
                  );
                },

                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: const VerticalDivider(
                    color: AppColors.primary,
                    indent: 10,
                    endIndent: 10,
                  ),
                ),

                itemCount: sortedCheckins.length,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
