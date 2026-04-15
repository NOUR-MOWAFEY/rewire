import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_dots_loading.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';

class GroupJoinCodeWidget extends StatelessWidget {
  const GroupJoinCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      buildWhen: (previous, current) =>
          current is GroupJoinCodeFailure ||
          current is GroupJoinCodeLoaded ||
          current is GroupJoinCodeLoading,

      listener: (BuildContext context, GroupState state) {
        if (state is GroupJoinCodeFailure) {
          ShowToastification.failure(context, 'Failed to load group id');
        }
      },

      builder: (context, state) {
        if (state is GroupJoinCodeLoaded) {
          return InkWell(
            borderRadius: BorderRadius.circular(32),
            onTap: () {
              Clipboard.setData(ClipboardData(text: state.joinCode)).then((
                value,
              ) {
                if (!context.mounted) return;
                ShowToastification.popUp(context, 'Copied to clipboard');
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(state.joinCode, style: AppStyles.textStyle20),
            ),
          );
        } else if (state is GroupJoinCodeLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: CustomDotsLoading(size: 26),
          );
        }

        return const Text(' Failed to load id', style: AppStyles.textStyle20);
      },
    );
  }
}
