import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/habit_item.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomAppBar(),
        ),
        SizedBox(height: 18),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: HabitItem(),
        ),
      ],
    );
  }
}
