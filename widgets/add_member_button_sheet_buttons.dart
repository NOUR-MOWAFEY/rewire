import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/group/presentation/views/group_settings_view/widgets/add_member_button.dart';


class AddMemberBottomSheetButtons extends StatelessWidget {
  const AddMemberBottomSheetButtons({
    super.key,
    required this.memberEmailController,
    required this.groupModel,
  });

  final TextEditingController memberEmailController;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () => context.pop(),
            title: 'Cancel',
            height: 45,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: BlocConsumer<MembersCubit, MembersState>(
            buildWhen: (previous, current) =>
                current is MembersAdded ||
                current is MembersLoading ||
                current is MembersError ||
                current is MembersNotFound,
            listener: (BuildContext context, MembersState state) {
              if (state is MembersAdded) {
                context.pop();
              }

              if (state is MembersNotFound) {
                ShowToastification.popUp(
                  context,
                  state.errMessage,
                  AppColors.red,
                );
              }

              if (state is MembersError) {
                ShowToastification.popUp(
                  context,
                  state.errMassage,
                  AppColors.red,
                );
              }
            },

            builder: (context, state) {
              if (state is MembersLoading || state is MembersAdded) {
                return const CustomButton(
                  color: Colors.grey,
                  height: 45,
                  child: CustomCircularLoading(size: 20),
                );
              }
              return AddMemberButton(
                memberEmailController: memberEmailController,
                groupModel: groupModel,
              );
            },
          ),
        ),
      ],
    );
  }
}
