import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewBackGroundContainer(viewBody: ProfileViewBody());
  }
}
