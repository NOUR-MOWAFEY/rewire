import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/utils/show_toastification.dart';
import '../../../../../../core/utils/validator.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/members_cubit/members_cubit.dart';

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

        var isMemberEmailValid = _isMemberEmailValid(context, email);

        if (!isMemberEmailValid) {
          return;
        }

        final membersCubit = context.read<MembersCubit>();

        var isMemberFound = await membersCubit.getMemberByEmail(
          email,
          getIt.get<FirebaseAuthService>().getCurrentUser()!.uid,
        );

        if (isMemberFound) {
          await membersCubit.sendInvitationByEmail(
            groupId: groupModel.id,
            groupName: groupModel.name,
            email: email,
            groupImageUpdatedAt: groupModel.imageUpdatedAt,
          );
        }
      },
      height: 45,
      title: 'Add',
      color: AppColors.green,
    );
  }

  bool _isMemberEmailValid(BuildContext context, String email) {
    if (email.isEmpty) {
      ShowToastification.popUp(
        context,
        'Please enter the member\'s email address',
        AppColors.red,
      );
      return false;
    }

    if (!emailRegex.hasMatch(email)) {
      ShowToastification.popUp(context, 'Invalid Email', AppColors.red);
      return false;
    }

    return true;
  }
}
