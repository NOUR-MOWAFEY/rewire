import 'package:flutter/material.dart';

import 'groups_view_app_bar.dart';

class GroupsViewEmptyBody extends StatelessWidget {
  const GroupsViewEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
      child: ListView(
        children: [
          const GroupsViewAppBar(),

          SizedBox(height: MediaQuery.of(context).size.height * 0.387),

          const Row(
            mainAxisAlignment: .center,
            children: [Text('Create or join a group to get started!')],
          ),
        ],
      ),
    );
  }
}
