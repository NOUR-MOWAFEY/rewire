import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/utils/show_toastification.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/group_cubit/group_cubit.dart';

class LeaveGroupAlertDialogButtons extends StatefulWidget {
  const LeaveGroupAlertDialogButtons({
    super.key,
    required this.isOwner,
    required this.groupModel,
  });

  final bool isOwner;
  final GroupModel groupModel;

  @override
  State<LeaveGroupAlertDialogButtons> createState() =>
      _LeaveGroupAlertDialogButtonsState();
}

class _LeaveGroupAlertDialogButtonsState
    extends State<LeaveGroupAlertDialogButtons> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(title: 'Cancel', onPressed: () => context.pop()),
        const SizedBox(height: 8),

        BlocListener<GroupCubit, GroupState>(
          listener: (context, state) {
            if (state is GroupLeaveSuccess) {
              context.pop();
              context.go(AppRouter.mainNavigationView);
              ShowToastification.success(
                context,
                'Group deleted successfully.',
              );
            }
          },
          child: _isLoading
              ? CustomButton(
                  color: Colors.grey,
                  onPressed: () {},
                  child: CustomCircularLoading(size: 20),
                )
              : CustomButton(
                  color: AppColors.red,
                  title: widget.isOwner ? 'Delete and Leave' : 'Leave',
                  onPressed: () {
                    setState(() => _isLoading = true);
                    context.read<GroupCubit>().leaveGroup(widget.groupModel);
                  },
                ),
        ),
      ],
    );
  }
}
