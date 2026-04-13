import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';

class InvitationsViewHeader extends StatelessWidget {
  const InvitationsViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(height: 60),
        Text('Group Invitations', style: AppStyles.textStyle28),
        SizedBox(height: 40),
      ],
    );
  }
}
