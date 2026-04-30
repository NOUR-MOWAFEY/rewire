import 'package:flutter/material.dart';

import 'invitation_view_header.dart';

class InvitationsListEmpty extends StatelessWidget {
  const InvitationsListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const InvitationsViewHeader(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.3),

        const Row(
          mainAxisAlignment: .center,
          children: [Text('No pending invitations')],
        ),
      ],
    );
  }
}
