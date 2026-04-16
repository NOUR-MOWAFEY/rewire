import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/groups_list.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/home_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/home_view_empty_body.dart';

import '../../../view_model/group_cubit/group_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

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
          return Center(child: Text(state.errMessage));
        }

        if (state is GroupSuccess &&
            state.groups != null &&
            state.groups!.isEmpty) {
          return const HomeViewEmptyBody();
        }

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 24, right: 24, left: 24),
                child: HomeViewAppBar(),
              ),
            ),

            GroupsList(
              groups: state is GroupSuccess ? state.groups : null,
              isLoading: state is GroupLoading,
            ),
          ],
        );
      },
    );
  }
}
