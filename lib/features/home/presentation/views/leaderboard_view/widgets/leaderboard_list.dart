import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_view_header.dart';

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.displayableGroups});

  final List<GroupModel> displayableGroups;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: LeaderboardViewHeader()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  LeaderboardItem(groupModel: displayableGroups[index]),
                  index == displayableGroups.length - 1
                      ? const SizedBox(height: 100)
                      : const SizedBox(),
                ],
              ),
            ),
            childCount: displayableGroups.length,
          ),
        ),
      ],
    );
  }
}
