import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../core/widgets/view_background_container.dart';
import '../../../auth/presentation/view_model/user_cubit/user_cubit.dart';
import '../../../group/presentation/view_model/group_cubit/group_cubit.dart';
import 'widgets/leaderboard_view_body.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: CustomRefreshIndicator(
        onRefresh: () async {
          final user = context.read<UserCubit>().currentUser;

          if (user == null) return;
          context.read<GroupCubit>().listenToGroups(user.uid);

          await Future.delayed(Duration(seconds: 5));
        },
        child: const LeaderboardViewBody(),
      ),
    );
  }
}
