import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/user_main_info.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const UserMainInfo(),
          const Spacer(),
          IconButton(
            onPressed: () async {
              await context.read<AuthCubit>().logout();
              if (context.mounted) {
                context.go(AppRouter.loginView);
              }
            },
            icon: const Icon(FontAwesomeIcons.gear, color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
