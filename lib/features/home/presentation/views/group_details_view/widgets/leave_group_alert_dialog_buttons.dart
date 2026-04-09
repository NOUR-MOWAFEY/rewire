import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';

class LeaveGroupAlertDialogButtons extends StatelessWidget {
  const LeaveGroupAlertDialogButtons({
    super.key,
    required this.isOwner,
    required this.groupModel,
  });

  final bool isOwner;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(title: 'Cancel', onPressed: () => context.pop()),
        const SizedBox(height: 8),

        BlocConsumer<GroupCubit, GroupState>(
          listener: (context, state) {
            if (state is GroupLeaveSuccess) {
              context.go(AppRouter.mainNavigationView);
              ShowToastification.success(
                context,
                'Group deleted successfully.',
              );
            }
          },
          builder: (context, state) {
            if (state is GroupLeaveLoading || state is GroupLeaveSuccess) {
              return CustomButton(
                color: Colors.grey,
                onPressed: () {},
                child: CustomLoading(size: 20),
              );
            }
            return CustomButton(
              color: AppColors.red,
              title: isOwner ? 'Delete and Leave' : 'Leave',
              onPressed: () async {
                context.read<GroupCubit>().leaveGroup(groupModel);
              },
            );
          },
        ),
      ],
    );
  }
}
