import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_stage_data.dart';

class LeaderboardStage extends StatelessWidget {
  const LeaderboardStage({
    super.key,
    required this.bgColor,
    required this.crownColor,
    required this.height,
    required this.borderColor,
    required this.iconAtTheTop,
  });

  final Color bgColor;
  final Color borderColor;
  final Color crownColor;
  final double height;
  final IconData iconAtTheTop;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: .stretch,

        children: [
          // hashtag + number
          Row(
            mainAxisAlignment: .center,

            children: [
              const Icon(FontAwesomeIcons.hashtag, size: 22),
              Icon(iconAtTheTop, size: 22),
            ],
          ),

          const SizedBox(height: 8),

          Container(
            height: height,

            decoration: BoxDecoration(
              color: bgColor,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),

              border: Border.all(color: borderColor, width: 2),
            ),

            child: LeaderboardStageData(crownColor: crownColor),
          ),
        ],
      ),
    );
  }
}
