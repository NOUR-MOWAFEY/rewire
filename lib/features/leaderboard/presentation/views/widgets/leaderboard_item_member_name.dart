import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../profile_view/data/models/user_model.dart';

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
