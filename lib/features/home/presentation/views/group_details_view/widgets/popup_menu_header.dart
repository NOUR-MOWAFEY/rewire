import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

import '../../../../../../core/utils/app_styles.dart';

class PopUpMenuHeader extends StatelessWidget {
  const PopUpMenuHeader({super.key, required this.checkIn});
  final CheckInModel checkIn;

  @override
  Widget build(BuildContext context) {
    final membersState = context.watch<MembersCubit>().state;
    final members = context.watch<MembersCubit>().members;

    final foundMember = members.firstWhere(
      (m) => m.uid == checkIn.userId,
      orElse: () => UserModel(
        uid: '',
        name: '',
        email: '',
        joinedAt: DateTime.now(),
        overallScore: 0,
      ),
    );

    String nameToShow;
    if (foundMember.uid.isNotEmpty) {
      nameToShow = foundMember.name;
    } else if (membersState is MembersLoading ||
        membersState is MembersInitial) {
      nameToShow = 'Loading...';
    } else {
      nameToShow = 'Unknown Member';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset('assets/images/pic.svg'),
        ),

        const SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nameToShow,
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   DateFormat.yMd().format(checkIn.createdAt),
            //   style: AppStyles.textStyle14,
            // ),
          ],
        ),
      ],
    );
  }
}
