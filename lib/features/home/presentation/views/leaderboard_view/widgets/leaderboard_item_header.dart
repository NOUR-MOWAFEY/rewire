import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_styles.dart';

class LeaderboardItemHeader extends StatelessWidget {
  const LeaderboardItemHeader({super.key, required this.groupName});

  final String groupName;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 6, top: 18),
        child: Text(
          groupName,
          style: AppStyles.textStyle22.copyWith(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
