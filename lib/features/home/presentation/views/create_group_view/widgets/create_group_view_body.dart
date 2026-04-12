import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/add_members_section.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_fields.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_app_bar.dart';

class CreateGroupViewBody extends StatelessWidget {
  const CreateGroupViewBody({
    super.key,
    required this.groupNameController,
    required this.createGroupKey,
    required this.memberEmailController,
    required this.groupPasswordController,
  });

  final TextEditingController groupNameController;
  final TextEditingController groupPasswordController;
  final GlobalKey<FormState> createGroupKey;
  final TextEditingController memberEmailController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGroupCubit, CreateGroupState>(
      builder: (context, state) {
        if (state is CreateGroupLoading ||
            state is CreateGroupSuccess ||
            state is CreateGroupFaliure) {
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

                Form(
                  key: createGroupKey,
                  child: CreateGroupFields(
                    groupNameController: groupNameController,
                    groupPasswordController: groupPasswordController,
                  ),
                ),

                const SizedBox(height: 24),

                AddMembersSection(memberEmailController: memberEmailController),
              ],
            ),
          ),
        );
      },
    );
  }
}
