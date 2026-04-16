import 'package:flutter/material.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitation_item.dart';

class InvitationsList extends StatelessWidget {
  const InvitationsList({super.key, required this.invitations});
  final List<InvitationModel> invitations;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Column(
          children: [
            InvitationItem(invitation: invitations[index]),
            index == invitations.length - 1
                ? const SizedBox(height: 100)
                : const SizedBox(height: 0),
          ],
        ),
        childCount: invitations.length,
      ),
    );
  }
}
