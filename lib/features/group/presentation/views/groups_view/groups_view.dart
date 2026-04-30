import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../../core/widgets/view_background_container.dart';
import '../../../../auth/presentation/view_model/user_cubit/user_cubit.dart';
import '../../view_model/group_cubit/group_cubit.dart';
import 'widgets/groups_view_body.dart';

class GroupsView extends StatelessWidget {
  const GroupsView({super.key});

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
        child: const GroupsViewBody(),
      ),
    );
  }
}
