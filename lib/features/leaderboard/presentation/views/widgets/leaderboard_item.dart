import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firestore/firestore_service.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../group/data/models/group_model.dart';
import '../../view_model/leaderboard_cubit/leaderboard_cubit.dart';
import 'leaderboard_item_body.dart';
import 'leaderboard_item_header.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LeaderboardCubit(getIt.get<FirestoreService>())
            ..getLeaderboard(groupModel.id),

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        height: 290,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: AppColors.transparentPrimary.withValues(alpha: 0.2),
        ),

        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () =>
              context.push(AppRouter.groupDetailsView, extra: groupModel),
          child: Column(
            children: [
              LeaderboardItemHeader(groupName: groupModel.name),

              LeaderboardItemBody(groupModel: groupModel),
            ],
          ),
        ),
      ),
    );
  }
}
