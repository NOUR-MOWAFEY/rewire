import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_data_fields.dart';

class GroupSettingsViewBody extends StatelessWidget {
  const GroupSettingsViewBody({
    super.key,
    required this.viewModel,
    required this.groupModel,
  });

  final GroupModel groupModel;
  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<DeleteGroupCubit, DeleteGroupState>(
        listener: (context, state) {
          if (state is DeleteGroupFailure) {
            ShowToastification.failure(
              context,
              'Couldn\'t delete group\nError: ${state.errMessage}',
            );
          } else if (state is DeleteGroupSuccess) {
            context.go(AppRouter.mainNavigationView);
            ShowToastification.success(context, 'Group deleted successfully');
          }
        },
        builder: (context, state) {
          if (state is DeleteGroupLoading || state is DeleteGroupSuccess) {
            return CustomLoading();
          }
          return ListView(
            children: [
              const SizedBox(height: 8),

              const SizedBox(height: 16),

              CustomAvatar(viewModel: viewModel),

              const SizedBox(height: 24),

              const GroupDataFields(),

              Align(
                alignment: .centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: CustomButton(
                    title: 'Save',
                    width: 90,
                    height: 40,
                    onPressed: () {},
                  ),
                ),
              ),
              const AddPeopleContainer(),

              CustomButton(
                title: 'Delete group',
                color: AppColors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          DeleteGroupCubit(getIt.get<FirestoreService>()),
                      child: DeleteGroupAlertDialog(groupModel: groupModel),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class DeleteGroupAlertDialog extends StatelessWidget {
  const DeleteGroupAlertDialog({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: AppColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      content: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: AppColors.gradientColors,
          ),
        ),
        height: 300,
        width: 330,

        child: BlocConsumer<DeleteGroupCubit, DeleteGroupState>(
          builder: (context, state) {
            if (state is DeleteGroupLoading || state is DeleteGroupSuccess) {
              return CustomLoading();
            }
            return Column(
              children: [
                const Text('Are you sure ?', style: AppStyles.textStyle28),
                const SizedBox(height: 12),

                Text(
                  'Are you sure you want to permanently delete this group?',
                  textAlign: .center,
                  style: AppStyles.textStyle16.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(218, 224, 224, 224),
                  ),
                ),

                const Spacer(),

                CustomButton(title: 'Cancel', onPressed: () => context.pop()),
                const SizedBox(height: 8),
                CustomButton(
                  color: AppColors.red,
                  title: 'delete',
                  onPressed: () async {
                    await BlocProvider.of<DeleteGroupCubit>(
                      context,
                    ).deleteGroup(groupModel.id);
                  },
                ),
              ],
            );
          },
          listener: (BuildContext context, DeleteGroupState state) {
            if (state is DeleteGroupSuccess) {
              context.go(AppRouter.mainNavigationView);
            }
          },
        ),
      ),
    );
  }
}
