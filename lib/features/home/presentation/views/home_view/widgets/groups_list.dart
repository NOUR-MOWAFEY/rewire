import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';

import 'group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key, required this.groups});

  final List<GroupModel>? groups;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(childCount: groups?.length ?? 0, (
          context,
          index,
        ) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GroupItem(
              groupModel: groups![index],
              isFirstItem: index == 0,
              isLastItem: index == groups!.length - 1,
            ),
          );
        }),
      ),
    );
  }
}
