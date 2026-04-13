import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item_group_name.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item_stages.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),

      height: 290,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,

      decoration: BoxDecoration(
        color: AppColors.transparentPrimary.withValues(alpha: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: const Column(
          children: [
            LeaderboardItemGroupName(),

            Spacer(),

            LeaderboardItemStages(),
          ],
        ),
      ),
    );
  }
}
