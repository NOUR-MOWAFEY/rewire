import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../data/models/day_model.dart';
import '../../../view_model/days_cubit/days_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'day_item.dart';

class DaysList extends StatelessWidget {
  const DaysList({super.key, required this.days, required this.isLoading});

  final List<DayModel>? days;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 5 : days?.length ?? 0;

    return Skeletonizer(
      enabled: isLoading,
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonBaseColor,
        highlightColor: AppColors.skeletonHighlightColor,
      ),
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          final dayString = days?[index].day ?? '';
          final dayCheckins =
              context.read<DaysCubit>().daysCheckins[dayString] ?? [];

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: DayItem(date: dayString, dayCheckins: dayCheckins),
          );
        },
      ),
    );
  }
}
