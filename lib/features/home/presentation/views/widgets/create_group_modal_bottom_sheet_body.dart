import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/validator.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/home/presentation/view_model/habit_cubit/habit_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container.dart';

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
          child: Column(
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
          ),
        ),
      ),
    );
  }
}

class GroupBottomSheetFooter extends StatelessWidget {
  const GroupBottomSheetFooter({
    super.key,
    required this.groupNameKey,
    required this.groupNameController,
  });

  final GlobalKey<FormState> groupNameKey;
  final TextEditingController groupNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            title: 'Create Group',
            onPressed: () async {
              if (!groupNameKey.currentState!.validate()) return;
              await BlocProvider.of<HabitCubit>(
                context,
              ).createHabit(groupNameController.text.trim());
              if (context.mounted) {
                context.pop();
              }
            },
          ),
        ),
        const SizedBox(width: 8),
        CustomButton(
          onPressed: () {},
          width: 50,
          child: const Icon(FontAwesomeIcons.plus, color: AppColors.white),
        ),
      ],
    );
  }
}
