import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/delete_group_cubit/delete_group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/profile_view_model.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_avatar.dart';
import 'package:rewire/features/home/presentation/views/widgets/delete_group_alert_dialog.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_data_fields.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_settings_app_bar.dart';

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
    return PopScope(
      canPop: context.read<DeleteGroupCubit>().isLoading,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<DeleteGroupCubit, DeleteGroupState>(
          listener: (context, state) {
            if (state is DeleteGroupFailure) {
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
            return ListView(
              children: [
                const GroupSettingsAppBar(),

                const SizedBox(height: 8),

                const SizedBox(height: 16),

                CustomAvatar(viewModel: viewModel),

                const SizedBox(height: 24),

                const GroupDataFields(),

                const SaveButton(),

                const AddPeopleContainer(),

                DeleteGroupButton(groupModel: groupModel),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DeleteGroupButton extends StatelessWidget {
  const DeleteGroupButton({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: 'Delete group',
      color: AppColors.red,
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => BlocProvider.value(
            value: context.read<DeleteGroupCubit>(),
            child: DeleteGroupAlertDialog(groupModel: groupModel),
          ),
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: CustomButton(
          title: 'Save',
          width: 90,
          height: 40,
          onPressed: () {},
        ),
      ),
    );
  }
}
