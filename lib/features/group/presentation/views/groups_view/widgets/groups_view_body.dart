import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'groups_list.dart';
import 'groups_view_app_bar.dart';
import 'groups_view_empty_body.dart';

import '../../../view_model/group_cubit/group_cubit.dart';

class GroupsViewBody extends StatelessWidget {
  const GroupsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      buildWhen: (previous, current) =>
          current is GroupSuccess ||
          current is GroupFailure ||
          current is GroupLoading ||
          current is GroupInitial,
      builder: (context, state) {
        if (state is GroupFailure) {
          // error body
          return Center(child: Text(state.errMessage));
        }

        if (state is GroupSuccess &&
            state.groups != null &&
            state.groups!.isEmpty) {
          // empty body
          return const GroupsViewEmptyBody();
        }

        return CustomScrollView(
          slivers: [
            // app bar
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 24, right: 24, left: 24),
                child: GroupsViewAppBar(),
              ),
            ),

            // group list
            GroupsList(
              groups: state is GroupSuccess ? state.groups : null,
              isLoading: state is GroupLoading || state is GroupInitial,
            ),
          ],
        );
      },
    );
  }
}
