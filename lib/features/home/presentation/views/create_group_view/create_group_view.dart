import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_button.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_body.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  final groupNameController = TextEditingController();
  final groupPasswordController = TextEditingController();
  final memberEmailController = TextEditingController();
  final createGroupKey = GlobalKey<FormState>();

  @override
  void dispose() {
    groupNameController.dispose();
    groupPasswordController.dispose();
    memberEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      bottomNavigationBar: CreategroupButton(
        groupNameKey: createGroupKey,
        groupNameController: groupNameController,
        groupPasswordController: groupPasswordController,
      ),

      viewBody: CreateGroupViewBody(
        groupNameController: groupNameController,
        createGroupKey: createGroupKey,
        memberEmailController: memberEmailController,
        groupPasswordController: groupPasswordController,
      ),
    );
  }
}
