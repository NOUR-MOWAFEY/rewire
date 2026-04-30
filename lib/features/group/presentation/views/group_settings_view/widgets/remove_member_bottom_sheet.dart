import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../profile_view/data/models/user_model.dart';
import '../../../../../profile_view/presentation/views/widgets/bottom_sheet_handle.dart';
import 'remove_bottom_sheet_button.dart';
import 'remove_bottom_sheet_header.dart';

class RemoveMemberBottomSheet extends StatelessWidget {
  const RemoveMemberBottomSheet({
    super.key,
    required this.member,
    required this.groupId,
  });

  final UserModel member;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 18),

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          const BottomSheetHandle(),

          const SizedBox(height: 24),

          // Avatar + name
          RemoveBottomSheetHeader(member: member),

          const SizedBox(height: 8),

          Text(
            'Are you sure you want to remove this member?',
            textAlign: TextAlign.center,
            style: AppStyles.textStyle14.copyWith(color: Colors.grey.shade400),
          ),

          const SizedBox(height: 24),

          // Buttons
          RemoveBottomSheetButtons(groupId: groupId, member: member),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
