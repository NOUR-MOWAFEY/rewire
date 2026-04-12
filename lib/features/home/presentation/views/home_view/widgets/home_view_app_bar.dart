import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/home_view_app_bar_buttons.dart';

class HomeViewAppBar extends StatelessWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              String name = '';
              if (state is UserSuccess) {
                name = state.user.name.split(RegExp(r'\s+'))[0];
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                child: Text('Hi, $name', style: AppStyles.textStyle28),
              );
            },
          ),
        ),

        const SizedBox(width: 4),

        const HomeViewAppBarButtons(),
      ],
    );
  }
}
