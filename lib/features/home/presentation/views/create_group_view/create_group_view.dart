import 'package:flutter/widgets.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_button.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_body.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({super.key});

  @override
  State<CreateGroupView> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView> {
  late TextEditingController groupNameController;
  late TextEditingController groupPasswordController;
  late TextEditingController memberEmailController;
  late GlobalKey<FormState> groupNameKey;

  @override
  void initState() {
    super.initState();
    _setInitialValues();
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
    groupPasswordController.dispose();
    memberEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      bottomNavigationBar: CreategroupButton(
        groupNameKey: groupNameKey,
        groupNameController: groupNameController,
        groupPasswordController: groupPasswordController,
      ),

      viewBody: CreateGroupViewBody(
        groupNameController: groupNameController,
        groupNameKey: groupNameKey,
        memberEmailController: memberEmailController,
        groupPasswordController: groupPasswordController,
      ),
    );
  }

  void _setInitialValues() async {
    groupNameController = TextEditingController();
    groupPasswordController = TextEditingController();
    memberEmailController = TextEditingController();
    groupNameKey = GlobalKey<FormState>();
  }
}
