import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
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
          current is GroupLoading,
      builder: (context, state) {
        final isLoading = state is GroupLoading;

        if (state is GroupFailure) {
          return Center(child: Text(state.errMessage));
        }

        final displayableGroups = state is GroupSuccess
            ? state.groups?.where((g) => g.members.length >= 2).toList() ?? []
            : <GroupModel>[]; // 👈 empty while loading

        if (!isLoading && displayableGroups.isEmpty) {
          return const LeaderboardViewEmptyBody();
        }

        return LeaderboardList(
          displayableGroups: displayableGroups,
          isLoading: isLoading,
        );
      },
    );
  }
}
