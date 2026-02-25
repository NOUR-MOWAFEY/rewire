import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';

class DeleteGroupAlertDialog extends StatelessWidget {
  const DeleteGroupAlertDialog({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
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
        height: 310,
        width: 350,

        child: Column(
          children: [
            const Text('Are you sure ?', style: AppStyles.textStyle28),
            const SizedBox(height: 12),

            Text(
              'Are you sure you want to permanently delete this group?',
              textAlign: .center,
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(218, 224, 224, 224),
              ),
            ),

            const Spacer(),

            CustomButton(title: 'Cancel', onPressed: () => context.pop()),
            const SizedBox(height: 8),
            CustomButton(
              color: AppColors.red,
              title: 'Delete',
              onPressed: () async {
                context.pop();
                await BlocProvider.of<DeleteGroupCubit>(
                  context,
                ).deleteGroup(groupModel.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
