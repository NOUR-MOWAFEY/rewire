import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_loading.dart';
import '../../view_model/habit_cubit/habit_cubit.dart';
import 'habit_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        if (state is HabitSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
              itemCount: state.habits!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: HabitItem(
                    habitModel: state.habits![index],
                    isFirstItem: index == 0,
                    isLastItem: index == state.habits!.length - 1,
                  ),
                );
              },
            ),
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
