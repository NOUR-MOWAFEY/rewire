import 'package:flutter/material.dart';
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
    final itemCount = isLoading ? 5 : displayableGroups.length;

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: LeaderboardViewHeader()),

        Skeletonizer.sliver(
          enabled: isLoading,
          effect: ShimmerEffect(
            baseColor: const Color.fromARGB(76, 94, 147, 108),
            highlightColor: const Color.fromARGB(192, 94, 147, 108),
          ),
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    LeaderboardItem(
                      groupModel: isLoading
                          ? GroupModel(
                              id: '00000000',
                              name: 'name',
                              createdBy: 'createdBy',
                              members: ['members', '', '', ''],
                              isActive: true,
                              joinCode: 'joinCode',
                              passwordHash: 'passwordHash',
                            )
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
