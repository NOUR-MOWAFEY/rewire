import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/remove_member_bottom_sheet.dart';

import 'user_main_info.dart';

class MembersListViewItem extends StatelessWidget {
  const MembersListViewItem({
    super.key,
    required this.member,
    this.groupModel,
    this.isMembersRemovable = true,
  });

  final UserModel member;
  final GroupModel? groupModel;
  final bool isMembersRemovable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          UserMainInfo(
            userModel: member,
            isAdmin: groupModel?.createdBy == member.uid,
          ),
          context.read<MembersCubit>().isCurrentUser(member) ||
                  !isMembersRemovable
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    var membersCubit = context.read<MembersCubit>();

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
                        : context.read<MembersCubit>().removeMemberFromList(
                            member,
                          );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.x,
                    size: 20,
                    color: Color.fromARGB(232, 189, 189, 189),
                  ),
                ),
        ],
      ),
    );
  }
}
