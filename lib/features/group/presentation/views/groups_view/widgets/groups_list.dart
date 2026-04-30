import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../data/models/group_model.dart';
import 'group_item.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({super.key, required this.groups, required this.isLoading});

  final List<GroupModel>? groups;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 7 : (groups?.length ?? 0);

    return Skeletonizer.sliver(
      enabled: isLoading,
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonBaseColor,
        highlightColor: AppColors.skeletonHighlightColor,
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
                groupModel: isLoading ? GroupModel.fakeData() : groups![index],
                isFirstItem: index == 0,
                isLastItem: index == itemCount - 1,
              ),
            );
          }),
        ),
      ),
    );
  }
}
