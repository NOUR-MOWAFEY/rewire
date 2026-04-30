import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../profile_view/data/models/user_model.dart';
import 'leaderboard_stage_data.dart';

class LeaderboardStage extends StatelessWidget {
  const LeaderboardStage({
    super.key,
    required this.bgColor,
    required this.crownColor,
    required this.height,
    this.borderColor,
    required this.iconAtTheTop,
    required this.user,
    required this.score,
  });

  final Color bgColor;
  final Color? borderColor;
  final Color crownColor;
  final double height;
  final IconData iconAtTheTop;
  final UserModel user;
  final num score;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.hashtag, size: 22),
              Icon(iconAtTheTop, size: 22),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: height,
            decoration: _leaderboardStageDecoration(),
            child: LeaderboardStageData(
              crownColor: crownColor,
              user: user,
              score: score,
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _leaderboardStageDecoration() {
    return BoxDecoration(
      color: bgColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      border: borderColor != null
          ? Border.all(color: borderColor!, width: 2)
          : null,
    );
  }
}
