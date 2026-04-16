import 'package:flutter/material.dart';
import 'package:rewire/core/utils/app_colors.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
