import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/small_group_image.dart';

class InvitationItemHeader extends StatelessWidget {
  const InvitationItemHeader({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallGroupImage(
          groupId: invitation.groupId,
          imageUpdatedAt: invitation.groupImageUpdatedAt,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invitation.groupName,
                style: AppStyles.textStyle18.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Invited by ${invitation.senderName}',
                style: AppStyles.textStyle14.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
