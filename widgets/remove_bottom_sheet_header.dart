import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';
import 'member_item_image.dart';

class RemoveBottomSheetHeader extends StatelessWidget {
  const RemoveBottomSheetHeader({super.key, required this.member});

  final UserModel member;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MemberItemImage(user: member, radius: 28),

        const SizedBox(height: 8),

        Text(
          member.name,
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
