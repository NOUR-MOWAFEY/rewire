import 'package:flutter/material.dart';

import 'leaderboard_view_header.dart';

class LeaderboardViewEmptyBody extends StatelessWidget {
  const LeaderboardViewEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const LeaderboardViewHeader(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.3),

        const Row(
          mainAxisAlignment: .center,
          children: [Text('You are not in any groups with enough members.')],
        ),
      ],
    );
  }
}
