import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/features/home/data/models/user_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

import 'user_main_info.dart';

class MembersListViewItem extends StatelessWidget {
  const MembersListViewItem({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          UserMainInfo(userModel: userModel),
          context.read<MembersCubit>().isCurrentUser(userModel)
              ? const SizedBox()
              : IconButton(
                  onPressed: () {
                    context.read<MembersCubit>().removeMemberFromList(
                      userModel,
                    );
                  },
                  icon: const Icon(
                    FontAwesomeIcons.x,
                    size: 20,
                    color: Color.fromARGB(232, 189, 189, 189),
                  ),
                ),
        ],
      ),
    );
  }
}
