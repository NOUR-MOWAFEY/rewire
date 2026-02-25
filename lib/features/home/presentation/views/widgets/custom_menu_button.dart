import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/group_model.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenubuttonItems>(
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

      onSelected: (value) {
        switch (value) {
          case MenubuttonItems.settings:
            context.push(AppRouter.groupSettingsView, extra: groupModel);
          case MenubuttonItems.leaveGroup:
            Clipboard.setData(ClipboardData(text: 'Hello'));
          case MenubuttonItems.deleteGroup:
        }
      },

      itemBuilder: (context) => const [
        PopupMenuItem(
          value: .settings,
          child: PopupMenuItemText(title: 'Settings'),
        ),
        PopupMenuItem(
          value: .deleteGroup,
          child: PopupMenuItemText(title: 'Delete Group'),
        ),
        PopupMenuItem(
          value: .leaveGroup,
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

enum MenubuttonItems { settings, deleteGroup, leaveGroup }
