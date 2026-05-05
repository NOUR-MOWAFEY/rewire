import 'package:flutter/material.dart';

import '../../../../../core/widgets/view_background_container.dart';
import '../../../data/models/group_model.dart';
import 'widgets/group_details_view_app_bar.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: GroupDetailsViewAppBar(groupModel: groupModel),
      viewBody: const GroupDetailsViewBody(),
    );
  }
}
