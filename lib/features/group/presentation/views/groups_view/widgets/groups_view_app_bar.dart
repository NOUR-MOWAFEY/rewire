import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'groups_view_app_bar_buttons.dart';

class GroupsViewAppBar extends StatelessWidget {
  const GroupsViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Text('Loading...', style: AppStyles.textStyle28);
              }

              String name = '';
              if (state is UserSuccess) {
                name = state.user.name.split(RegExp(r'\s+'))[0];
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const PageScrollPhysics(),
                child: Text('Hi, $name', style: AppStyles.textStyle28),
              );
            },
          ),
        ),

        const SizedBox(width: 4),

        const GroupsViewAppBarButtons(),
      ],
    );
  }
}
