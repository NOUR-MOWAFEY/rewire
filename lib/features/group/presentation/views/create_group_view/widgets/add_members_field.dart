import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/services/firebase_auth_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/service_locator.dart';
import '../../../../../../core/utils/show_toastification.dart';
import '../../../../../../core/utils/validator.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_circular_loading.dart';
import '../../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../../view_model/create_group_cubit/create_group_cubit.dart';
import '../../../view_model/members_cubit/members_cubit.dart';

class AddMembersField extends StatelessWidget {
  const AddMembersField({super.key});

  @override
  Widget build(BuildContext context) {
    final createGroupCubit = context.read<CreateGroupCubit>();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Text field: does NOT rebuild on MembersCubit state changes ──
          Expanded(
            child: CustomTextFormField(
              title: 'Invite member email',
              controller: createGroupCubit.memberEmailController,
              icon: FontAwesomeIcons.solidEnvelope,
              isLastOne: false,
              border: false,
            ),
          ),

          const SizedBox(width: 6),

          // ── Only the button reacts to state ─────────────────────────────
          BlocConsumer<MembersCubit, MembersState>(
            // Only rebuild when state changes to/from loading
            buildWhen: (prev, curr) =>
                (prev is MembersLoading) != (curr is MembersLoading),

            listener: (context, state) {
              if (state is MembersError) {
                ShowToastification.failure(context, state.errMassage);
              }
              if (state is MembersNotFound) {
                ShowToastification.failure(context, state.errMessage);
              }
              if (state is MembersFound) {
                context.read<MembersCubit>().members.add(state.user);
                createGroupCubit.memberEmailController.clear();
              }
            },

            builder: (BuildContext context, MembersState state) {
              if (state is MembersLoading) {
                return const CustomButton(
                  width: 75,
                  child: CustomCircularLoading(size: 12),
                );
              }

              return CustomButton(
                width: 75,
                onPressed: () async {
                  final email =
                      createGroupCubit.memberEmailController.text
                          .trim()
                          .toLowerCase();

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
                  log(context.read<MembersCubit>().members.toString());
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
