import 'package:flutter/material.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitations_view_body.dart';

class InvitationsView extends StatelessWidget {
  const InvitationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ViewBackGroundContainer(viewBody: InvitationsViewBody());
  }
}
