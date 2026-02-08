import 'package:flutter/material.dart';
import '../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewBackGroundContainer(viewBody: GroupDetailsViewBody());
  }
}
