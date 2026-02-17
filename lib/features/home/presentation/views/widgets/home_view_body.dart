import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_app_bar.dart';

import '../../../../../core/widgets/custom_loading.dart';
import '../../view_model/habit_cubit/habit_cubit.dart';
import 'group_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        if (state is HabitSuccess) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 16, right: 24, left: 24),
                  child: CustomAppBar(),
                ),
              ),
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 18),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.habits?.length ?? 0,
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GroupItem(
                          habitModel: state.habits![index],
                          isFirstItem: index == 0,
                          isLastItem: index == state.habits!.length - 1,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is HabitFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return const CustomLoading();
        }
      },
    );
  }
}
