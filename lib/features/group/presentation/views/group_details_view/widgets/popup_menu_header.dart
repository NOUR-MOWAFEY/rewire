import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../profile_view/data/models/user_model.dart';
import '../../../../data/models/checkin_model.dart';
import '../../../view_model/members_cubit/members_cubit.dart';
import '../../create_group_view/widgets/member_item_image.dart';

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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MemberItemImage(user: foundMember),

        const SizedBox(width: 8),

        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (foundMember.uid.isNotEmpty)
                  Text(
                    foundMember.name,
                    style: AppStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else if (membersState is MembersLoaded ||
                    membersState is MembersError ||
                    membersState is MembersNotFound)
                  Text(
                    'Unknown Member',
                    style: AppStyles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                else
                  LoadingAnimationWidget.progressiveDots(
                    color: Colors.white,
                    size: 25,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
