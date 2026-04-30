import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class CustomDotsLoading extends StatelessWidget {
  const CustomDotsLoading({super.key, this.size});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: AppColors.white,
        size: size ?? MediaQuery.of(context).size.height / 21,
      ),
    );
  }
}
