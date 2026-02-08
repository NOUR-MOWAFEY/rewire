import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'user_main_info.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 4),
      child: SizedBox(
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
      ),
    );
  }
}
