import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';

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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
                  child: Row(
                    children: [
                      const Text('Hi, Nour', style: AppStyles.textStyle28),
                      const Spacer(),
                      CustomButton(
                        width: 90,
                        height: 40,
                        title: 'Create',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 6),
                      CustomButton(
                        width: 65,
                        height: 40,
                        title: 'join',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 28),
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
