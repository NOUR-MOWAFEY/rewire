import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/create_group_modal_bottom_sheet_body.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      showFloatingActionButton: true,
      floatingButtonOnPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const CreateGroupModalBottomSheetBody(),
        );
      },
      viewBody: const HomeViewBody(),
    );
  }
}
