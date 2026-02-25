import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_back_button.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';

class GroupSettingsAppBar extends StatelessWidget {
  const GroupSettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CustomBackButton(),

        const SizedBox(width: 8),

        BlocConsumer<JoinGroupCubit, JoinGroupState>(
          builder: (context, state) {
            return InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: () {
                state is JoinCodeLoaded
                    ? Clipboard.setData(
                        ClipboardData(text: state.joinCode),
                      ).then((value) {
                        if (!context.mounted) return;
                        ShowToastification.popUp(
                          context,
                          'Copied to clipboard',
                        );
                      })
                    : null;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'ID: ',
                      style: AppStyles.textStyle20.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    state is JoinCodeLoaded
                        ? Text(
                            state.joinCode,
                            style: AppStyles.textStyle20.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'Loading...',
                            style: AppStyles.textStyle20.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white60,
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
          listener: (BuildContext context, JoinGroupState state) {
            if (state is JoinGroupFailure) {
              ShowToastification.failure(context, 'Failed to load group id');
            }
          },
        ),
      ],
    );
  }
}
