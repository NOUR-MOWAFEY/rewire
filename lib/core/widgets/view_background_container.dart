import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ViewBackGroundContainer extends StatelessWidget {
  const ViewBackGroundContainer({
    super.key,
    required this.viewBody,
    this.appBar,
    this.showFloatingActionButton = false,
    this.floatingButtonOnPressed,
  });
  final Widget viewBody;
  final PreferredSizeWidget? appBar;
  final bool showFloatingActionButton;
  final void Function()? floatingButtonOnPressed;

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

        // floatingActionButton: showFloatingActionButton
        //     ? FloatingActionButton(

        //       )
        // : null,
        body: SafeArea(bottom: false, child: viewBody),
      ),
    );
  }
}
