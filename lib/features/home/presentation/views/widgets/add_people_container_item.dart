import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/home/presentation/views/widgets/user_main_info.dart';

class AddPeopleContainerItem extends StatelessWidget {
  const AddPeopleContainerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const UserMainInfo(),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.minus),
          ),
        ],
      ),
    );
  }
}
