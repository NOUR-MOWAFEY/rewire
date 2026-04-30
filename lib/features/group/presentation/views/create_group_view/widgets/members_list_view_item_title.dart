import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../profile_view/data/models/user_model.dart';
import '../../../view_model/members_cubit/members_cubit.dart';

class MembersListViewItemTitle extends StatelessWidget {
  const MembersListViewItemTitle({
    super.key,
    required this.member,
    required this.isAdmin,
  });

  final UserModel member;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            member.name,
            style: AppStyles.textStyle16.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        context.read<MembersCubit>().isCurrentUser(member)
            ? Text(' (You)', style: AppStyles.textStyle14)
            : const SizedBox(),

        isAdmin
            ? const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  FontAwesomeIcons.crown,
                  color: Colors.amber,
                  size: 14,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
