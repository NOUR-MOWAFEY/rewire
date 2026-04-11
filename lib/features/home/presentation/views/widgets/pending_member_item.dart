import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/data/models/invitation_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class PendingMemberItem extends StatelessWidget {
  const PendingMemberItem({super.key, required this.invitation});

  final InvitationModel invitation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        minTileHeight: 45,

        leading: CircleAvatar(
          backgroundColor: AppColors.secondary,
          child: Text(
            invitation.receiverName.isNotEmpty
                ? invitation.receiverName[0].toUpperCase()
                : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),

        title: Text(
          invitation.receiverName,
          style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(
          invitation.receiverEmail,
          style: AppStyles.textStyle12.copyWith(color: Colors.white60),
        ),

        trailing: IconButton(
          onPressed: () =>
              context.read<MembersCubit>().cancelInvitation(invitation.id),
          icon: const Icon(
            FontAwesomeIcons.xmark,
            color: AppColors.red,
            size: 18,
          ),
        ),
      ),
    );
  }
}
