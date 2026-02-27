import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/delete_group_button.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_data_fields.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_settings_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_save_button.dart';

class GroupSettingsViewBody extends StatelessWidget {
  const GroupSettingsViewBody({
    super.key,
    required this.viewModel,
    required this.groupModel,
    required this.groupNameController,
    required this.groupPasswordController,
    required this.updateGroupDataKey,
  });

  final GroupModel groupModel;
  final ProfileViewModel viewModel;

  final TextEditingController groupNameController;
  final TextEditingController groupPasswordController;
  final GlobalKey<FormState> updateGroupDataKey;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.read<DeleteGroupCubit>().isLoading,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<DeleteGroupCubit, DeleteGroupState>(
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
            if (state is DeleteGroupLoading || state is DeleteGroupSuccess) {
              return const CustomLoading();
            }
            return Form(
              key: updateGroupDataKey,

              child: ListView(
                children: [
                  const GroupSettingsViewAppBar(),

                  const SizedBox(height: 24),

                  AnimatedBuilder(
                    animation: viewModel,
                    builder: (BuildContext context, Widget? child) {
                      return CustomAvatar(
                        viewModel: viewModel,
                        imageType: ImageType.group,
                        groupId: groupModel.id,
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  GroupDataFields(
                    groupNameController: groupNameController,
                    groupPasswordController: groupPasswordController,
                  ),

                  CustomSaveButton(
                    onPressed: () async {
                      if (!updateGroupDataKey.currentState!.validate()) {
                        return;
                      }

                      await context
                          .read<GroupCubit>()
                          .updateGroupData(
                            groupModel.id,
                            groupNameController.text,
                            groupPasswordController.text,
                          )
                          .then((value) {
                            groupNameController.clear();
                            groupPasswordController.clear();
                          });
                    },
                  ),

                  const AddPeopleContainer(),

                  DeleteGroupButton(groupModel: groupModel),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
