import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/profile_view/data/models/user_model.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/group/presentation/views/create_group_view/widgets/members_list_view_item_title.dart';
import 'member_item_image.dart';
import 'members_list_view_item_remove_icon.dart';

class MembersListViewItem extends StatelessWidget {
  const MembersListViewItem({
    super.key,
    required this.member,
    this.isAdmin = false,
    this.groupModel,
    this.isMembersRemovable = true,
  });
  final UserModel member;
  final GroupModel? groupModel;
  final bool isAdmin;
  final bool isMembersRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minTileHeight: 45,

        leading: MemberItemImage(user: member),

        title: MembersListViewItemTitle(member: member, isAdmin: isAdmin),

        subtitle: Text(
          member.email,
          style: AppStyles.textStyle12.copyWith(color: Colors.white60),
          overflow: TextOverflow.ellipsis,
        ),

        trailing:
            context.read<MembersCubit>().isCurrentUser(member) ||
                !isMembersRemovable
            ? const SizedBox()
            : MembersListViewItemRemoveIcon(
                groupModel: groupModel,
                member: member,
              ),
      ),
    );
  }
}
