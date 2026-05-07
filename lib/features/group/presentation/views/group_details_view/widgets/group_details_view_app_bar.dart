import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rewire/core/utils/app_router.dart';
import 'package:rewire/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:rewire/features/group/data/models/group_details_view_model.dart';
import 'package:rewire/features/group/data/models/group_info_view_data.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/group/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/group/presentation/views/group_details_view/widgets/group_main_info.dart';

import '../../../../../../core/widgets/custom_back_button.dart';
import '../../../view_model/group_cubit/group_cubit.dart';
import 'custom_menu_button.dart';

class GroupDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GroupDetailsViewAppBar({
    super.key,
    required this.groupDetailsViewModel,
  });

  final GroupDetailsViewModel groupDetailsViewModel;

  @override
  Widget build(BuildContext context) {
    final groupModel = groupDetailsViewModel.groupModel;
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          const CustomBackButton(color: Colors.transparent),
          const SizedBox(width: 6),
          BlocBuilder<GroupCubit, GroupState>(
            buildWhen: (previous, current) => current is GroupSuccess,
            builder: (context, state) {
              final name = state is GroupSuccess
                  ? (state.groups?.firstWhere(
                              (g) => g.id == groupModel.id,
                              orElse: () => groupModel,
                            ) ??
                            groupModel)
                        .name
                  : groupModel.name;

              return Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: () {
                    _groupMainInfoOnTap(context, groupModel);
                  },

                  child: GroupMainInfo(
                    groupDetailsViewModel: groupDetailsViewModel,
                    name: name,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        CustomMenuButton(groupModel: groupModel),
        const SizedBox(width: 6),
      ],
    );
  }

  void _groupMainInfoOnTap(BuildContext context, GroupModel groupModel) {
    final currentUserId = context.read<AuthCubit>().getUser()!.uid;
    final isOwner = groupModel.createdBy == currentUserId;

    if (isOwner) {
      context.push(
        AppRouter.groupSettingsView,
        extra: GroupDataModel(
          groupModel: groupModel,
          membersCubit: context.read<MembersCubit>(),
          groupCubit: context.read<GroupCubit>(),
        ),
      );
    } else {
      context.push(
        AppRouter.groupInfoView,
        extra: GroupDataModel(
          groupModel: groupModel,
          membersCubit: context.read<MembersCubit>(),
          groupCubit: context.read<GroupCubit>(),
        ),
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
