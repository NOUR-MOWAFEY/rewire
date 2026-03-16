import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container_item.dart';

class MembersListView extends StatelessWidget {
  const MembersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,

      itemBuilder: (BuildContext context, int index) {
        return const AddPeopleContainerItem();
      },

      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 14);
      },
    );
  }
}
