import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/invitation_model.dart';
import 'invitation_item.dart';

class InvitationsList extends StatelessWidget {
  const InvitationsList({
    super.key,
    required this.invitations,
    required this.isLoading,
  });
  final List<InvitationModel>? invitations;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final itemCount = isLoading ? 4 : invitations?.length ?? 0;
    return Skeletonizer.sliver(
      enabled: isLoading,
      effect: const ShimmerEffect(
        baseColor: AppColors.skeletonBaseColor,
        highlightColor: AppColors.skeletonHighlightColor,
      ),
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Column(
            children: [
              InvitationItem(
                invitation: invitations?[index] ?? InvitationModel.fakeData(),
              ),
              index == itemCount - 1
                  ? const SizedBox(height: 100)
                  : const SizedBox(height: 0),
            ],
          ),
          childCount: itemCount,
        ),
      ),
    );
  }
}
