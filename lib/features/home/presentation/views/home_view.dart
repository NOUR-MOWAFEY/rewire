import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/view_background_container.dart';

import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewBackGroundContainer(viewBody: HomeViewBody());
  }
}
