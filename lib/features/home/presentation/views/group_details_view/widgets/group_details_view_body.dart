import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';

import 'day_item.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6),

      child: BlocConsumer<DaysCubit, DaysState>(
        listener: (context, state) {
          if (state is DaysFailure) {
            ShowToastification.failure(context, 'Failed to load group data');
          }
        },
        builder: (context, state) {
          final days = context.read<DaysCubit>().daysList;

          if (days.isNotEmpty) {
            return ListView.builder(
              itemCount: days.length,
              itemBuilder: (BuildContext context, int index) {
                final dayString = days[index].day;
                final dayCheckins =
                    context.read<DaysCubit>().daysCheckins[dayString] ?? [];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: DayItem(date: dayString, dayCheckins: dayCheckins),
                );
              },
            );
          } else if (state is DaysLoading) {
            return const CustomLoading();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
