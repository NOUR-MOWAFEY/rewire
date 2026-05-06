import 'package:flutter/material.dart';
import 'package:rewire/core/utils/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../group/data/models/group_model.dart';
import 'leaderboard_item.dart';
import 'leaderboard_view_header.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({
    super.key,
    required this.displayableGroups,
    required this.isLoading,
  });

  final List<GroupModel> displayableGroups;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 3 : displayableGroups.length;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: LeaderboardViewHeader()),

        Skeletonizer.sliver(
          enabled: isLoading,
          effect: const ShimmerEffect(
            baseColor: AppColors.skeletonBaseColor,
            highlightColor: AppColors.skeletonHighlightColor,
          ),
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    LeaderboardItem(
                      groupModel: isLoading
                          ? GroupModel.fakeData().copyWith(id: 'fake_$index')
                          : displayableGroups[index],
                    ),
                    index == itemCount - 1
                        ? const SizedBox(
                            height: AppConstants.spaceForBottomNavBar,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              childCount: isLoading ? 4 : itemCount,
            ),
          ),
        ),
      ],
    );
  }
}
