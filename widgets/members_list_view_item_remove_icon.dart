import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'remove_member_bottom_sheet.dart';

class MembersListViewItemRemoveIcon extends StatelessWidget {
  const MembersListViewItemRemoveIcon({
    super.key,
    required this.groupModel,
    required this.member,
  });

  final GroupModel? groupModel;
  final UserModel member;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final membersCubit = context.read<MembersCubit>();

        groupModel != null
            ? showModalBottomSheet(
                context: context,
                backgroundColor: AppColors.alertDialogColor,
                builder: (context) => BlocProvider.value(
                  value: membersCubit,
                  child: RemoveMemberBottomSheet(
                    member: member,
                    groupId: groupModel!.id,
                  ),
                ),
              )
            : context.read<MembersCubit>().removeMemberFromList(member);
      },
      icon: const Icon(FontAwesomeIcons.xmark, color: AppColors.red, size: 18),
    );
  }
}
