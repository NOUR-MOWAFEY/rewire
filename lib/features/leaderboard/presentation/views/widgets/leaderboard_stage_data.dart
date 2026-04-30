import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../profile_view/data/models/user_model.dart';
import 'leaderboard_item_member_image.dart';
import 'leaderboard_item_member_name.dart';
import 'leaderboard_item_member_points.dart';

class LeaderboardStageData extends StatelessWidget {
  const LeaderboardStageData({
    super.key,
    required this.crownColor,
    required this.user,
    required this.score,
  });

  final Color crownColor;
  final UserModel user;
  final num score;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Transform.rotate(
            angle: -0.3,
            child: Icon(FontAwesomeIcons.crown, color: crownColor),
          ),
        ),

        LeaderboardItemMemberImage(user: user),

        const SizedBox(height: 4),

        LeaderboardItemMemberName(user: user),

        LeaderboardItemMemberPoints(score: score),
      ],
    );
  }
}
