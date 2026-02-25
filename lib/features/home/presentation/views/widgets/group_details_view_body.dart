import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';

import 'check_group_item.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
      
      child: BlocConsumer<DaysCubit, DaysState>(
        listener: (context, state) {
          if (state is DaysFailure) {
            ShowToastification.failure(
              context,
              'Failed to load group data\nError: ${state.errMessage}',
            );
          }
        },
        builder: (context, state) {
          if (state is DaysLoaded) {
            return ListView.builder(
              itemCount: state.days.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CheckGroupItem(date: state.days[index].day),
                );
              },
            );
          } else if (state is DaysLoading) {
            return const CustomLoading();
          }
          return SizedBox();
        },
      ),
    );
  }
}
