import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_refresh_indicator.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';

import '../../../../../core/widgets/view_background_container.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
        child: const HomeViewBody(),
      ),
    );
  }
}
