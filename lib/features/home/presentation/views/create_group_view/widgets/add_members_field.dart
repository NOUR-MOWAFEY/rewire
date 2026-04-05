import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

import '../../../../../auth/presentation/views/widgets/custom_text_form_field.dart';

class AddMembersField extends StatelessWidget {
  const AddMembersField({super.key, required this.memberEmailController});
  final TextEditingController memberEmailController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: CustomTextFormField(
              title: 'Member email',
              controller: memberEmailController,
              icon: FontAwesomeIcons.solidEnvelope,
              isLastOne: false,
              border: false,
            ),
          ),

          const SizedBox(width: 6),

          BlocConsumer<MembersCubit, MembersState>(
            listener: (context, state) {
              if (state is MembersError) {
                ShowToastification.failure(context, state.errMassage);
              }

              if (state is MembersNotFound) {
                ShowToastification.failure(context, state.errMessage);
              }

              if (state is MembersFound) {
                context.read<MembersCubit>().membersIds.add(state.user.uid);
                context.read<MembersCubit>().members.add(state.user);
                memberEmailController.clear();
              }
            },

            builder: (BuildContext context, MembersState state) {
              if (state is MembersLoading) {
                return const CustomButton(
                  width: 75,
                  child: CustomLoading(size: 12),
                );
              }

              return CustomButton(
                width: 75,

                onPressed: () async {
                  var email = memberEmailController.text.trim().toLowerCase();

                  if (email.isNotEmpty) {
                    if (!emailRegex.hasMatch(email)) {
                      ShowToastification.failure(context, 'Invalid Email');
                      return;
                    }

                    await context.read<MembersCubit>().getMemberByEmail(
                      email,
                      getIt.get<FirebaseAuthService>().getCurrentUser()!.uid,
                    );
                  }

                  if (!context.mounted) return;

                  log(context.read<MembersCubit>().membersIds.toString());
                },

                child: const Icon(
                  FontAwesomeIcons.plus,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
