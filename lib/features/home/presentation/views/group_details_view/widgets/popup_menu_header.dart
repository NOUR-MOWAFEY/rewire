import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:rewire/features/home/data/models/checkin_model.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

import '../../../../../../core/utils/app_styles.dart';

class PopUpMenuHeader extends StatelessWidget {
  const PopUpMenuHeader({super.key, required this.checkIn});
  final CheckInModel checkIn;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<MembersCubit>().members.firstWhere(
      (element) => element.uid == checkIn.userId,
      orElse: () => UserModel(
        uid: '',
        name: 'Unknown Member',
        email: '',
        joinedAt: DateTime.now(),
        overallScore: 0,
      ),
    );

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
              user.name,
              style: AppStyles.textStyle16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat.yMd().format(checkIn.createdAt),
              style: AppStyles.textStyle14,
            ),
          ],
        ),
      ],
    );
  }
}
