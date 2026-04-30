import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import '../../../../data/models/group_model.dart';
import 'leave_group_alert_dialog_buttons.dart';

class LeaveGroupAlertDialog extends StatelessWidget {
  const LeaveGroupAlertDialog({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthCubit>().getUser()!.uid;
    final isOwner = groupModel.createdBy == currentUserId;

    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      content: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: AppColors.gradientColors,
          ),
        ),

        width: 350,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure ?', style: AppStyles.textStyle28),
            const SizedBox(height: 12),

            Text(
              isOwner
                  ? "Leaving this group will delete it because you are the admin.\nDo you want to continue?"
                  : 'Are you sure you want to Leave this group?',
              textAlign: TextAlign.center,
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(218, 224, 224, 224),
              ),
            ),

            const SizedBox(height: 24),

            LeaveGroupAlertDialogButtons(
              isOwner: isOwner,
              groupModel: groupModel,
            ),
          ],
        ),
      ),
    );
  }
}
