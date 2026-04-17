import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_view_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
                          ? GroupModel.fakeData()
                          : displayableGroups[index],
                    ),
                    index == itemCount - 1
                        ? const SizedBox(height: 100)
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
