import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/invitation_model.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.invitation,
    this.onPressed,
    required this.bgColor,
    required this.title,
    this.isLoading = false,
  });

  final InvitationModel invitation;
  final void Function()? onPressed;
  final Color bgColor;
  final String title;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: bgColor.withValues(alpha: 0.6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: isLoading
          ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 2,
            ),
          )
          : Text(title),
    );
  }
}
