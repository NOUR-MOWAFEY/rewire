import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/view_background_container.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(viewBody: const HomeViewBody());
  }
}
