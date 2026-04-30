import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/invitation_model.dart';
import '../../view_model/invitations_cubit/invitations_cubit.dart';
import 'custom_elevated_button.dart';

class InvitationItemButtons extends StatelessWidget {
  const InvitationItemButtons({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvitationsCubit, InvitationsState>(
      builder: (context, state) {
        String? loadingId;
        bool isDeclining = false;

        if (state is InvitationsSuccess) {
          loadingId = state.loadingId;
          isDeclining = state.isDeclining;
        }

        final isThisItemLoading = loadingId == invitation.id;

        return Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                title: 'Accept',
                bgColor: AppColors.green.withValues(alpha: 0.8),
                invitation: invitation,
                isLoading: isThisItemLoading && !isDeclining,
                onPressed: isThisItemLoading
                    ? null
                    : () => context.read<InvitationsCubit>().acceptInvitation(
                        invitation,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomElevatedButton(
                title: 'Decline',
                bgColor: AppColors.red.withValues(alpha: 0.5),
                invitation: invitation,
                isLoading: isThisItemLoading && isDeclining,
                onPressed: isThisItemLoading
                    ? null
                    : () => context.read<InvitationsCubit>().declineInvitation(
                        invitation,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
