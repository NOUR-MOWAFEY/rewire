import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_refresh_indicator.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/presentation/view_model/invitations_cubit/invitations_cubit.dart';
import 'package:rewire/features/home/presentation/views/invitations_view/widgets/invitations_view_body.dart';

class InvitationsView extends StatelessWidget {
  const InvitationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      viewBody: CustomRefreshIndicator(
        onRefresh: () async {
          context.read<InvitationsCubit>().listenToInvitations();
          await Future.delayed(Duration(seconds: 5));
        },
        child: const InvitationsViewBody(),
      ),
    );
  }
}
