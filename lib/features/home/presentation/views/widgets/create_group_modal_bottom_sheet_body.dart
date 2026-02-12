import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/views/widgets/group_bottom_sheet_footer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../auth/presentation/views/widgets/custom_text_form_field.dart';
import '../../view_model/habit_cubit/habit_cubit.dart';
import 'add_people_container.dart';

class CreateGroupModalBottomSheetBody extends StatefulWidget {
  const CreateGroupModalBottomSheetBody({super.key});

  @override
  State<CreateGroupModalBottomSheetBody> createState() =>
      _CreateGroupModalBottomSheetBodyState();
}

class _CreateGroupModalBottomSheetBodyState
    extends State<CreateGroupModalBottomSheetBody> {
  late TextEditingController groupNameController;
  late GlobalKey<FormState> groupNameKey;

  @override
  void initState() {
    super.initState();
    groupNameController = TextEditingController();
    groupNameKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    groupNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: groupNameKey,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 550,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.gradientColors,
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: BlocConsumer<HabitCubit, HabitState>(
            listener: (BuildContext context, HabitState state) {
              if (state is HabitFailure) {
                ShowToastification.failure(
                  context,
                  'Cannot creat group, error: ${state.errMessage}',
                );
              }
              if (state is HabitCreated) {
                // context.pop();
              }
            },
            builder: (context, state) {
              if (state is HabitLoading) {
                return const CustomLoading();
              }
              return Column(
                children: [
                  CustomTextFormField(
                    title: 'Group name',
                    icon: FontAwesomeIcons.peopleGroup,
                    inputType: InputType.name,
                    isLastOne: true,
                    controller: groupNameController,
                  ),
                  const AddPeopleContainer(),
                  GroupBottomSheetFooter(
                    groupNameKey: groupNameKey,
                    groupNameController: groupNameController,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
