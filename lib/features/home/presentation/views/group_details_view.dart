import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_details_view_app_bar.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key, required this.groupName});
  final String groupName;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: CustomDetailsViewAppBar(groupName: groupName),
      viewBody: const GroupDetailsViewBody(),
    );
  }
}
