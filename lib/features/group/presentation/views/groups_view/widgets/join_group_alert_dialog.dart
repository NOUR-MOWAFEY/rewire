import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_colors.dart';
import 'join_group_form.dart';

class JoinGroupAlertDialog extends StatelessWidget {
  const JoinGroupAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AlertDialog(
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
          width: MediaQuery.of(context).size.width,

          child: const JoinGroupForm(),
        ),
      ),
    );
  }
}
