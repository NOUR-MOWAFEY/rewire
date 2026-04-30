import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/show_toastification.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../view_model/create_group_cubit/create_group_cubit.dart';
import '../../../view_model/members_cubit/members_cubit.dart';

class CreategroupButton extends StatelessWidget {
  const CreategroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
        listener: (BuildContext context, CreateGroupState state) {
          if (state is CreateGroupFaliure) {
            context.pop();

            if (state.errMessage == 'Connection timeout') {
              ShowToastification.warning(
                context,
                'Connection timeout. Groups will sync when you\'re back online',
              );
              return;
            }
            ShowToastification.failure(context, 'Cannot create group');
          }
          if (state is CreateGroupSuccess) {
            ShowToastification.success(context, 'Group created successfully');
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is CreateGroupLoading || state is CreateGroupSuccess) {
            return const SizedBox();
          }

          return CustomButton(
            title: 'Create Group',
            onPressed: () async {
              final cubit = context.read<CreateGroupCubit>();
              if (!cubit.createGroupKey.currentState!.validate()) return;

              cubit.createGroup(
                title: cubit.groupNameController.text.trim(),
                password: cubit.groupPasswordController.text,
                invitedUsers: context.read<MembersCubit>().members.toList(),
              );
            },
          );
        },
      ),
    );
  }
}
