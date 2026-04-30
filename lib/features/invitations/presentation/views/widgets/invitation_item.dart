import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/invitation_model.dart';
import 'invitation_item_buttons.dart';
import 'invitation_item_header.dart';

class InvitationItem extends StatelessWidget {
  const InvitationItem({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.transparentPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InvitationItemHeader(invitation: invitation),

          const SizedBox(height: 26),

          InvitationItemButtons(invitation: invitation),
        ],
      ),
    );
  }
}
