import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/show_toastification.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/delete_group_cubit/delete_group_cubit.dart';
import 'delete_group_alert_dialog.dart';

class DeleteGroupButton extends StatelessWidget {
  const DeleteGroupButton({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteGroupCubit, DeleteGroupState>(
      listener: (context, state) {
        if (state is DeleteGroupFailure) {
          if (state.errMessage == 'Connection timeout') {
            context.go(AppRouter.mainNavigationView);
            ShowToastification.warning(
              context,
              'Connection timeout. Groups will sync when you\'re back online',
            );
            return;
          }
          ShowToastification.failure(context, 'Couldn\'t delete group');
        } else if (state is DeleteGroupSuccess) {
          context.go(AppRouter.mainNavigationView);

          ShowToastification.success(context, 'Group deleted successfully');
        }
      },
      builder: (context, state) {
        return state is DeleteGroupLoading || state is DeleteGroupSuccess
            ? const CustomButton(
                color: Colors.grey,
                child: CustomCircularLoading(size: 20),
              )
            : CustomButton(
                title: 'Delete group',
                color: AppColors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: context.read<DeleteGroupCubit>(),
                      child: DeleteGroupAlertDialog(groupModel: groupModel),
                    ),
                  );
                },
              );
      },
    );
  }
}
