import 'package:flutter/material.dart';

import 'check_group_item.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
      child: ListView(children: [const CheckGroupItem()]),
    );
  }
}
