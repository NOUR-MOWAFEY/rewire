import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_refresh_indicator.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/days_list.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        context.read<DaysCubit>().listenToDays();
        await context.read<DaysCubit>().addDays();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 6),

        child: BlocConsumer<DaysCubit, DaysState>(
          listener: (context, state) {
            if (state is DaysFailure) {
              ShowToastification.failure(context, 'Failed to load group data');
            }
          },
          builder: (context, state) {
            if (state is DaysFailure) {
              return ListView();
            }

            final days = context.read<DaysCubit>().daysList;
            return DaysList(
              days: state is DaysLoaded ? days : null,
              isLoading: state is DaysLoading || state is DaysInitial,
            );
          },
        ),
      ),
    );
  }
}
