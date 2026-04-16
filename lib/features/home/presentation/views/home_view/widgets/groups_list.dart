import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key, required this.groups, required this.isLoading});

  final List<GroupModel>? groups;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 10 : (groups?.length ?? 0);

    return Skeletonizer.sliver(
      enabled: isLoading,
      effect: ShimmerEffect(
        baseColor: const Color.fromARGB(111, 94, 147, 108),
        highlightColor: const Color.fromARGB(192, 94, 147, 108),
      ),
      child: SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: itemCount, (
            context,
            index,
          ) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GroupItem(
                groupModel: isLoading ? _fakeData() : groups![index],
                isFirstItem: index == 0,
                isLastItem: index == itemCount - 1,
              ),
            );
          }),
        ),
      ),
    );
  }

  GroupModel _fakeData() {
    return GroupModel(
      id: 'id',
      name: 'name',
      createdBy: 'createdBy',
      members: ['members'],
      isActive: true,
      joinCode: 'joinCode',
      passwordHash: 'passwordHash',
    );
  }
}
