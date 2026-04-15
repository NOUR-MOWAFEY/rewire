import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/home/data/models/group_info_view_data.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/group_details_view/widgets/leave_group_alert_dialog.dart';
import 'package:rewire/features/home/presentation/views/qr_view/qr_view.dart';

class CustomMenuButton extends StatelessWidget {
  const CustomMenuButton({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final currentUserId = context.read<AuthCubit>().getUser()!.uid;
    final isOwner = groupModel.createdBy == currentUserId;

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
            final membersCubit = context.read<MembersCubit>();
            final groupCubit = context.read<GroupCubit>();

            context.push(
              AppRouter.groupSettingsView,
              extra: GroupDataModel(
                groupModel: groupModel,
                membersCubit: membersCubit,
                groupCubit: groupCubit,
              ),
            );

          case MenubuttonItems.leaveGroup:
            final groupCubit = context.read<GroupCubit>();

            showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: groupCubit,
                child: LeaveGroupAlertDialog(groupModel: groupModel),
              ),
            );

          case MenubuttonItems.info:
            final membersCubit = context.read<MembersCubit>();

            context.push(
              AppRouter.groupInfoView,
              extra: GroupDataModel(
                groupModel: groupModel,
                membersCubit: membersCubit,
                groupCubit: context.read<GroupCubit>(),
              ),
            );
          case MenubuttonItems.qr:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QrView(groupModel: groupModel),
              ),
            );
        }
      },

      itemBuilder: (context) => [
        const PopupMenuItem(
          value: MenubuttonItems.info,
          child: PopupMenuItemText(title: 'Info'),
        ),

        if (isOwner)
          const PopupMenuItem(
            value: MenubuttonItems.settings,
            child: PopupMenuItemText(title: 'Settings'),
          ),

        if (isOwner)
          const PopupMenuItem(
            value: MenubuttonItems.qr,
            child: PopupMenuItemText(title: 'Share QR'),
          ),

        const PopupMenuItem(
          value: MenubuttonItems.leaveGroup,
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

enum MenubuttonItems { info, settings, leaveGroup, qr }
