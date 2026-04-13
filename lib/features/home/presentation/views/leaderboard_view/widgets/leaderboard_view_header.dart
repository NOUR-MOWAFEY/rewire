import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';

class LeaderboardViewHeader extends StatelessWidget {
  const LeaderboardViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(height: 60),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text('Leaderboard', style: AppStyles.textStyle28),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
