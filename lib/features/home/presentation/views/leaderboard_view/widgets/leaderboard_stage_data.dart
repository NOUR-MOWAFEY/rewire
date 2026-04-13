import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class LeaderboardStageData extends StatelessWidget {
  const LeaderboardStageData({super.key, required this.crownColor});

  final Color crownColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Transform.rotate(
            angle: -0.3,
            child: Icon(FontAwesomeIcons.crown, color: crownColor),
          ),
        ),

        CircleAvatar(backgroundImage: AssetImage('assets/images/pic.png')),

        const SizedBox(height: 4),

        Text(
          'Nour Mowafey',
          style: AppStyles.textStyle12.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}
