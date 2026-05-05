import 'package:flutter/material.dart';
import 'package:rewire/features/group/data/models/group_details_view_model.dart';

import '../../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_app_bar.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key, required this.groupDetailsViewModel});

  final GroupDetailsViewModel groupDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: GroupDetailsViewAppBar(
        groupDetailsViewModel: groupDetailsViewModel,
      ),
      viewBody: const GroupDetailsViewBody(),
    );
  }
}
