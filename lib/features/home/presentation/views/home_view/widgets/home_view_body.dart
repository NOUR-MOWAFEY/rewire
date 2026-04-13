import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/groups_list.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/home_view_app_bar.dart';

import '../../../../../../core/widgets/custom_loading.dart';
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
        if (state is GroupSuccess) {
          return CustomScrollView(
            slivers: [
              // app bar
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 24, right: 24, left: 24),
                  child: HomeViewAppBar(),
                ),
              ),

              // groups list view
              GroupsList(groups: state.groups),
            ],
          );
        } else if (state is GroupFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const CustomLoading();
        }
      },
    );
  }
}
