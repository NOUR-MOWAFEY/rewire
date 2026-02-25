import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class JoinGroupAlertDialog extends StatelessWidget {
  const JoinGroupAlertDialog({super.key});

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
        height: 380,
        width: 350,
        child: Column(
          children: [
            const Text('Join Group', style: AppStyles.textStyle24),
            const SizedBox(height: 20),

            const CustomUnderlineTextField(hintText: 'Group ID'),
            const SizedBox(height: 12),
            const CustomUnderlineTextField(hintText: 'Password'),
            const SizedBox(height: 24),

            const Spacer(),

            CustomButton(title: 'Cancel', onPressed: () => context.pop()),
            const SizedBox(height: 8),
            CustomButton(title: 'Join', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
