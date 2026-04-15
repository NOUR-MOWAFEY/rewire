import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item_stages.dart';

class LeaderboardItemBody extends StatelessWidget {
  const LeaderboardItemBody({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        if (state is LeaderboardSuccess) {
          final sortedMembers = List<UserModel>.from(state.sortedMembers)
            ..sort((a, b) {
              final scoreA = groupModel.memberCommitments[a.uid] ?? 0;
              final scoreB = groupModel.memberCommitments[b.uid] ?? 0;
              return scoreB.compareTo(scoreA);
            });

          return Expanded(
            child: LeaderboardItemStages(
              members: sortedMembers,
              groupModel: groupModel,
            ),
          );
        } else if (state is LeaderboardFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return Expanded(child: const CustomCircularLoading(size: 32));
        }
      },
    );
  }
}
