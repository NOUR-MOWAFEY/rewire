import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_view_header.dart';

class LeaderboardViewBody extends StatelessWidget {
  const LeaderboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: LeaderboardViewHeader()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  const LeaderboardItem(),
                  index == 4 ? const SizedBox(height: 100) : const SizedBox(),
                ],
              ),
            ),
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
