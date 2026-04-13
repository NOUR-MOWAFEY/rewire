import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_stage.dart';

class LeaderboardItemStages extends StatelessWidget {
  const LeaderboardItemStages({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: .end,

      children: [
        LeaderboardStage(
          bgColor: const Color.fromARGB(
            255,
            122,
            122,
            122,
          ).withValues(alpha: 0.3),
          borderColor: AppColors.silver,
          crownColor: AppColors.silver,
          iconAtTheTop: FontAwesomeIcons.two,
          height: 155,
        ),

        const SizedBox(width: 8),

        LeaderboardStage(
          bgColor: const Color.fromARGB(
            255,
            158,
            134,
            0,
          ).withValues(alpha: 0.3),
          borderColor: AppColors.gold,
          crownColor: AppColors.gold,
          iconAtTheTop: FontAwesomeIcons.one,
          height: 190,
        ),

        const SizedBox(width: 8),

        LeaderboardStage(
          bgColor: const Color.fromARGB(
            255,
            156,
            97,
            38,
          ).withValues(alpha: 0.3),
          borderColor: AppColors.bronze,
          crownColor: AppColors.bronze,
          iconAtTheTop: FontAwesomeIcons.three,
          height: 120,
        ),
      ],
    );
  }
}
