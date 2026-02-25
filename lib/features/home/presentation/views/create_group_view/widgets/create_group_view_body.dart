import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_footer.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_app_bar.dart';

import '../../../../../../core/utils/validator.dart';
import '../../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../widgets/add_people_container.dart';

class CreateGroupViewBody extends StatelessWidget {
  const CreateGroupViewBody({
    super.key,
    required this.groupNameController,
    required this.groupNameKey,
    required this.groupPasswordController,
  });

  final TextEditingController groupNameController;
  final GlobalKey<FormState> groupNameKey;
  final TextEditingController groupPasswordController;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: context.read<CreateGroupCubit>().isLoading,
      child: Form(
        key: groupNameKey,
        child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
          listener: (BuildContext context, CreateGroupState state) {
            if (state is CreateGroupFaliure) {
              if (state.errMessage == 'Connection timeout') {
                context.pop();
                ShowToastification.warning(
                  context,
                  'Connection timeout. Groups will sync when you\'re back online',
                );
                return;
              }
              ShowToastification.failure(context, 'Cannot creat group');
            }
            if (state is CreateGroupSuccess) {
              ShowToastification.success(context, 'Group created successfully');
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is CreateGroupLoading || state is CreateGroupSuccess) {
              return const CustomLoading();
            }
            return Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    const CreateGroupViewAppBar(),

                    const SizedBox(height: 24),

                    CustomTextFormField(
                      title: 'Group name',
                      icon: FontAwesomeIcons.userGroup,
                      inputType: InputType.name,
                      isLastOne: false,
                      controller: groupNameController,
                    ),

                    const AddPeopleContainer(),

                    CreateGroupFooter(
                      groupNameKey: groupNameKey,
                      groupNameController: groupNameController,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
