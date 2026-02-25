import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/delete_group_alert_dialog.dart';

class DeleteGroupButton extends StatelessWidget {
  const DeleteGroupButton({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
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
  }
}
