import 'package:flutter/material.dart';

import 'invitation_view_header.dart';

class InvitationsErrorBody extends StatelessWidget {
  const InvitationsErrorBody({super.key, required this.errMessage});
  final String errMessage;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const InvitationsViewHeader(),

        SizedBox(height: MediaQuery.of(context).size.height * 0.3),

        Row(
          mainAxisAlignment: .center,
          children: [
            Text(errMessage, style: const TextStyle(color: Colors.red)),
          ],
        ),
      ],
    );
  }
}
