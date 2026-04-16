import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/home_view_app_bar.dart';

class HomeViewEmptyBody extends StatelessWidget {
  const HomeViewEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24, right: 24, left: 24),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,

        children: [
          HomeViewAppBar(),
          Expanded(
            child: Center(
              child: Text('Create or join a group to get started!'),
            ),
          ),
        ],
      ),
    );
  }
}
