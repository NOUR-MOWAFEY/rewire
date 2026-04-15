import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_list.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_view_empty_body.dart';

class LeaderboardViewBody extends StatelessWidget {
  const LeaderboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      buildWhen: (previous, current) =>
          current is GroupSuccess ||
          current is GroupFailure ||
          current is GroupLoading ||
          current is GroupInitial,
      builder: (context, state) {
        if (state is GroupSuccess) {
          final displayableGroups =
              state.groups?.where((g) => g.members.length >= 2).toList() ?? [];

          if (displayableGroups.isEmpty) {
            return LeaderboardViewEmptyBody();
          }

          return LeaderboardList(displayableGroups: displayableGroups);
        } else if (state is GroupFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const CustomCircularLoading();
        }
      },
    );
  }
}
