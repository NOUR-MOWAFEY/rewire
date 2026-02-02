import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rewire/core/utils/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: AppColors.white,
        size: MediaQuery.of(context).size.height / 21,
        secondRingColor: AppColors.primary,
        thirdRingColor: AppColors.secondary2,
      ),
    );
  }
}
