import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const CustomBackButton(),
      ),
      viewBody: const GroupDetailsViewBody(),
    );
  }
}
