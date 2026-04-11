import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/members_list_view_item.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({
    super.key,
    required this.users,
    this.groupModel,
    this.shrinkWrap = false,
    this.physics,
    this.isMembersRemovable = true,
  });
  final List<UserModel> users;
  final GroupModel? groupModel;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool isMembersRemovable;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: users.length,

      itemBuilder: (BuildContext context, int index) {


        return MembersListViewItem(
          member: users[index],
          isAdmin: groupModel?.createdBy == users[index].uid,
          isMembersRemovable: isMembersRemovable,
          groupModel: groupModel,
        );
      },
    );
  }
}
