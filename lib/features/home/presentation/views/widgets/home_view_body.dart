import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(
        title: 'SignOut',
        onPressed: () async =>
            await BlocProvider.of<AuthCubit>(context).logout(),
      ),
    );
  }
}
