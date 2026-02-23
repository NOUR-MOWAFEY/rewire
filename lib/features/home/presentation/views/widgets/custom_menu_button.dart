import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      menuPadding: const EdgeInsets.symmetric(vertical: 8),

      offset: const Offset(0, 50),
      color: AppColors.alertDialogColor,
      icon: const Icon(
        FontAwesomeIcons.ellipsisVertical,
        color: AppColors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(18),
      ),

      itemBuilder: (context) => const [
        PopupMenuItem(
          value: '',
          child: PopupMenuItemText(title: 'Settings'),
        ),
        PopupMenuItem(
          value: '',
          child: PopupMenuItemText(title: 'Delete Group'),
        ),
        PopupMenuItem(
          value: '',
          child: PopupMenuItemText(title: 'Leave Group'),
        ),
      ],
    );
  }
}

class PopupMenuItemText extends StatelessWidget {
  const PopupMenuItemText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(title, style: AppStyles.textStyle14),
    );
  }
}
