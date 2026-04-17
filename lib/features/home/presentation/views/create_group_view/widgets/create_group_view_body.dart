import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/add_members_section.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_fields.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/create_group_view_app_bar.dart';

class CreateGroupViewBody extends StatelessWidget {
  const CreateGroupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateGroupCubit>();

    return BlocBuilder<CreateGroupCubit, CreateGroupState>(
      builder: (context, state) {
        if (state is CreateGroupLoading ||
            state is CreateGroupSuccess ||
            state is CreateGroupFaliure) {
          return const CustomCircularLoading();
        }

        return Padding(
          padding: const EdgeInsets.all(16),

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CreateGroupViewAppBar(),

                const SizedBox(height: 24),

                Form(
                  key: cubit.createGroupKey,
                  child: const CreateGroupFields(),
                ),

                const SizedBox(height: 24),

                const AddMembersSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
