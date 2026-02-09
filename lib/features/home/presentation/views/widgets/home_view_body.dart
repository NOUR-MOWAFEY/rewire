import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_loading.dart';
import '../../view_model/habit_cubit/habit_cubit.dart';
import 'custom_app_bar.dart';
import 'habit_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        if (state is HabitSuccess) {
          return Column(
            children: [
              const CustomAppBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: state.habits!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 24,
                        right: 24,
                        bottom: 8,
                      ),
                      child: HabitItem(habitModel: state.habits![index]),
                    );
                  },
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
