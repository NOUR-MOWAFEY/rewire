import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/member_item_image.dart';

import '../../../../../core/utils/app_styles.dart';

class UserMainInfo extends StatelessWidget {
  const UserMainInfo({
    super.key,
    required this.userModel,
    this.isAdmin = false,
  });
  final UserModel userModel;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MemberItemImage(user: userModel, radius: 30),
        const SizedBox(width: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  userModel.name,
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                context.read<MembersCubit>().isCurrentUser(userModel)
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
            ),
            Text(
              userModel.email,
              style: AppStyles.textStyle14.copyWith(
                color: const Color.fromARGB(232, 189, 189, 189),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
