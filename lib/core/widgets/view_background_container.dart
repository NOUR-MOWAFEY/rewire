import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ViewBackGroundContainer extends StatelessWidget {
  const ViewBackGroundContainer({
    super.key,
    required this.viewBody,
    this.appBar,
  });
  final Widget viewBody;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
          colors: AppColors.gradientColors,
        ),
      ),
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(child: viewBody),
      ),
    );
  }
}
