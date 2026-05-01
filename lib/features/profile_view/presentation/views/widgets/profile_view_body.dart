import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/show_toastification.dart';
import '../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../auth/presentation/view_model/user_cubit/user_cubit.dart';
import 'profile_view_app_bar.dart';
import 'user_data_form.dart';
import 'user_image_builder.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: AppColors.white,
      backgroundColor: AppColors.transparentPrimary,
      onRefresh: () async {
        final user = context.read<UserCubit>().currentUser;

        if (user != null) context.read<UserCubit>().listenToUser(user.uid);

        await Future.delayed(Duration(seconds: 5));
      },
      child: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserSuccess) {
            return ListView(
              children: [
                ProfileViewAppBar(user: state.user),

                const SizedBox(height: 60),

                const UserImageBuilder(),

                const SizedBox(height: 40),

                const UserDataForm(),
              ],
            );
          }
          return const Center(child: CustomCircularLoading(size: 32));
        },

        listener: (BuildContext context, UserState state) {
          if (state is UserFailure) {
            ShowToastification.failure(context, state.errMessage);
          }
        },
      ),
    );
  }
}
