import 'package:flutter/material.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const ProfileViewBody(),
      ),
    );
  }
}
