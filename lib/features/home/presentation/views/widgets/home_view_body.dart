import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/habit_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        if (state is HabitSucess) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  top: 4,
                ),
                child: const CustomAppBar(),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.habits.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: 8,
                      ),
                      child: HabitItem(habitModel: state.habits[index]),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (state is HabitFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return CustomLoading();
        }
      },
    );
  }
}
