import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/members_cubit/members_cubit.dart';
import 'members_list_view.dart';

class InvitedGroupMembersListView extends StatelessWidget {
  const InvitedGroupMembersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembersCubit, MembersState>(
      buildWhen: (prev, curr) {
        final prevCount = prev is MembersLoaded
            ? prev.members.length
            : (prev is MembersFound ? -1 : null);
        final currCount = curr is MembersLoaded
            ? curr.members.length
            : (curr is MembersFound ? -1 : null);
        return prevCount != currCount;
      },
      builder: (context, state) {
        final members = context.read<MembersCubit>().members.toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Text(
                '${members.length} member${members.length == 1 ? '' : 's'} added',
                style: AppStyles.textStyle12.copyWith(
                  color: Colors.white54,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            MembersListView(
              users: members,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        );
      },
    );
  }
}
