import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';

class CustomLogoutButton extends StatelessWidget {
  const CustomLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Align(
        alignment: .centerRight,
        child: IconButton(
          onPressed: () async {
            await BlocProvider.of<AuthCubit>(context).logout();
            if (!context.mounted) return;
            context.go(AppRouter.loginView);
          },
          padding: const EdgeInsets.all(12),
          icon: const Icon(
            FontAwesomeIcons.rightFromBracket,
            color: AppColors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
