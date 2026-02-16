import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.white,
        size: size ?? MediaQuery.of(context).size.height / 21,
        secondRingColor: AppColors.primary,
        thirdRingColor: AppColors.secondary2,
      ),
    );
  }
}
