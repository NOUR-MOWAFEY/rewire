import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_view_header.dart';

class LeaderboardViewEmptyBody extends StatelessWidget {
  const LeaderboardViewEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: LeaderboardViewHeader()),
        SliverFillRemaining(
          child: Center(
            child: Text('You are not in any groups with enough members.'),
          ),
        ),
      ],
    );
  }
}
