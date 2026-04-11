import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';

class InvitationItemHeader extends StatelessWidget {
  const InvitationItemHeader({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.transparentPrimary,
          child: Icon(
            FontAwesomeIcons.userGroup,
            size: 16,
            color: Color.fromARGB(213, 224, 224, 224),
          ),
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
