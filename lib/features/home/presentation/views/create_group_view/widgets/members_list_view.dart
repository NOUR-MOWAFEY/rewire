import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/members_list_view_item.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,

      itemBuilder: (BuildContext context, int index) {
        return MembersListViewItem(userModel: users[index]);
      },

      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 14);
      },
    );
  }
}
