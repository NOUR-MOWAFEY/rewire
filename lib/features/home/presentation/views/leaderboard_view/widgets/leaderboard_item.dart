import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/leaderboard_cubit/leaderboard_cubit.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item_body.dart';
import 'package:rewire/features/home/presentation/views/leaderboard_view/widgets/leaderboard_item_header.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 6),
        height: 290,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.transparentPrimary.withValues(alpha: 0.2),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
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
