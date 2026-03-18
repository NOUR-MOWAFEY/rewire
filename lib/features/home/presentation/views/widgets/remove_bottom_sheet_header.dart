import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/user_model.dart';

class RemoveBottomSheetHeader extends StatelessWidget {
  const RemoveBottomSheetHeader({super.key, required this.member});

  final UserModel member;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.primary,
          // backgroundImage: NetworkImage(member.),
          radius: 30,
        ),
        const SizedBox(height: 12),

        Text(
          member.name,
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
