import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/members_list_view_item.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({
    super.key,
    required this.users,
    this.groupModel,

  });
  final List<UserModel> users;
  final GroupModel? groupModel;


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,

      itemBuilder: (BuildContext context, int index) {
        return MembersListViewItem(
          member: users[index],
          groupModel: groupModel,
        );
      },

      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 14);
      },
    );
  }
}
