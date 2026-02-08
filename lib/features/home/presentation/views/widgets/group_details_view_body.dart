import 'package:flutter/material.dart';
import 'check_group_item.dart';
import 'custom_app_bar.dart';

class GroupDetailsViewBody extends StatelessWidget {
  const GroupDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
  return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(children: [CheckGroupItem()]),
          ),
        ),
      ],
    );
  }
}
