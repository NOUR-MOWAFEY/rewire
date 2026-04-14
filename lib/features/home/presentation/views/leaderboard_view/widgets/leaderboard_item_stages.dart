import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_stage.dart';

class LeaderboardItemStages extends StatelessWidget {
  const LeaderboardItemStages({
    super.key,
    required this.members,
    required this.groupModel,
  });

  final List<UserModel> members;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (members.length >= 2)
          LeaderboardStage(
            user: members[1],
            score: groupModel.memberCommitments[members[1].uid] ?? 0,
            bgColor: const Color.fromARGB(
              255,
              144,
              144,
              144,
            ).withValues(alpha: 0.35),
            // borderColor: AppColors.silver,
            crownColor: AppColors.silver,
            iconAtTheTop: FontAwesomeIcons.two,
            height: 155,
          )
        else
          const Spacer(),

        const SizedBox(width: 8),

        if (members.isNotEmpty)
          LeaderboardStage(
            user: members[0],
            score: groupModel.memberCommitments[members[0].uid] ?? 0,
            bgColor: const Color.fromARGB(
              255,
              171,
              145,
              0,
            ).withValues(alpha: 0.35),
            // borderColor: AppColors.gold,
            crownColor: AppColors.gold,
            iconAtTheTop: FontAwesomeIcons.one,
            height: 190,
          )
        else
          const Spacer(),

        const SizedBox(width: 8),

        if (members.length >= 3)
          LeaderboardStage(
            user: members[2],
            score: groupModel.memberCommitments[members[2].uid] ?? 0,
            bgColor: const Color.fromARGB(
              255,
              164,
              102,
              40,
            ).withValues(alpha: 0.35),
            // borderColor: AppColors.bronze,
            crownColor: AppColors.bronze,
            iconAtTheTop: FontAwesomeIcons.three,
            height: 120,
          )
        else
          const Spacer(),
      ],
    );
  }
}
