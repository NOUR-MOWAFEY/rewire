import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';
import 'package:rewire/features/home/presentation/view_model/invitations_cubit/invitations_cubit.dart';

class InvitationItemButtons extends StatelessWidget {
  const InvitationItemButtons({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () =>
                context.read<InvitationsCubit>().acceptInvitation(invitation),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.green.withValues(alpha: 0.8),
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Accept'),
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: ElevatedButton(
            onPressed: () =>
                context.read<InvitationsCubit>().declineInvitation(invitation),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.red.withValues(alpha: 0.5),
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Decline'),
          ),
        ),
      ],
    );
  }
}
