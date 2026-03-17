import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firebase_auth_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class AddMemberBottomSheet extends StatefulWidget {
  const AddMemberBottomSheet({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<AddMemberBottomSheet> createState() => _AddMemberBottomSheetState();
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet> {
  late TextEditingController memberEmailController;

  @override
  void initState() {
    memberEmailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    memberEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 18),

              Text('Add Member', style: AppStyles.textStyle22),

              const SizedBox(height: 36),

              CustomTextFormField(
                title: 'Member email',
                controller: memberEmailController,
                icon: FontAwesomeIcons.solidEnvelope,
                isLastOne: false,
                border: false,
              ),

              const SizedBox(height: 18),

              // Buttons
              Row(
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
                      listener: (BuildContext context, MembersState state) {
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
                        if (state is MembersLoading) {
                          return CustomButton(
                            color: Colors.grey,
                            height: 45,
                            child: const CustomLoading(size: 20),
                          );
                        }
                        return CustomButton(
                          onPressed: () async {
                            var email = memberEmailController.text
                                .trim()
                                .toLowerCase();

                            if (email.isEmpty) {
                              ShowToastification.popUp(
                                context,
                                'Please enter the member\'s email address',
                                AppColors.red,
                              );
                              return;
                            }

                            if (!emailRegex.hasMatch(email)) {
                              ShowToastification.popUp(
                                context,
                                'Invalid Email',
                                AppColors.red,
                              );
                              return;
                            }

                            var isMemberFound = await context
                                .read<MembersCubit>()
                                .getMemberByEmail(
                                  email,
                                  getIt
                                      .get<FirebaseAuthService>()
                                      .getCurrentUser()!
                                      .uid,
                                );
                            if (!context.mounted) return;

                            if (isMemberFound) {
                              await context
                                  .read<MembersCubit>()
                                  .addMemberByEmail(
                                    groupId: widget.groupModel.id,
                                    email: email,
                                  );
                            }
                          },
                          height: 45,
                          title: 'Add',
                          color: AppColors.green,
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
