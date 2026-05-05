import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/features/group/data/models/group_model.dart';

import '../../../../../core/utils/app_styles.dart';

class LeaderboardItemHeader extends StatelessWidget {
  const LeaderboardItemHeader({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 18, right: 20),
        child: Hero(
          tag: '${AppRouter.leaderboardView}_name_${groupModel.id}',
          child: Material(
            color: Colors.transparent,
            child: Text(
              groupModel.name,
              style: AppStyles.textStyle22.copyWith(
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
