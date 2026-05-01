import 'package:flutter/material.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/group/presentation/views/group_settings_view/widgets/pending_member_item.dart';

class MembersPendingListView extends StatelessWidget {
  const MembersPendingListView({super.key, required this.state});
  final MembersLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.pendingInvitations.length,

      itemBuilder: (context, index) {
        return PendingMemberItem(invitation: state.pendingInvitations[index]);
      },
    );
  }
}
