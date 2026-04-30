import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class LeaderboardItemMemberPoints extends StatelessWidget {
  const LeaderboardItemMemberPoints({super.key, required this.score});

  final num score;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          '${score.toInt()} pts',
          style: AppStyles.textStyle12.copyWith(
            fontSize: 10,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
