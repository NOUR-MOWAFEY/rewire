import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

class LeaderboardItemMemberName extends StatelessWidget {
  const LeaderboardItemMemberName({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          user.name.split(' ').first,
          style: AppStyles.textStyle12.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
