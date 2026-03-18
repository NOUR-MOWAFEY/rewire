import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class AddMemberButton extends StatelessWidget {
  const AddMemberButton({
    super.key,
    required this.memberEmailController,
    required this.groupModel,
  });

  final TextEditingController memberEmailController;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        var email = memberEmailController.text.trim().toLowerCase();

        _memberEmailValidator(context, email);

        var isMemberFound = await context.read<MembersCubit>().getMemberByEmail(
          email,
          getIt.get<FirebaseAuthService>().getCurrentUser()!.uid,
        );

        if (!context.mounted) return;

        if (isMemberFound) {
          await context.read<MembersCubit>().addMemberByEmail(
            groupId: groupModel.id,
            email: email,
          );
        }

        if (!context.mounted) return;

        context.pop();
      },
      height: 45,
      title: 'Add',
      color: AppColors.green,
    );
  }

  void _memberEmailValidator(BuildContext context, String email) {
    if (email.isEmpty) {
      ShowToastification.popUp(
        context,
        'Please enter the member\'s email address',
        AppColors.red,
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ShowToastification.popUp(context, 'Invalid Email', AppColors.red);
      return;
    }
  }
}
