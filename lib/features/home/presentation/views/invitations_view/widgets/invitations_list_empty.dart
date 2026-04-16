import 'package:flutter/material.dart';

class InvitationsListEmpty extends StatelessWidget {
  const InvitationsListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: Center(
        child: Text(
          'No pending invitations',
          style: TextStyle(color: Colors.white60),
        ),
      ),
    );
  }
}
