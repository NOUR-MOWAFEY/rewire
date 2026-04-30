import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/group_cubit/group_cubit.dart';
import 'custom_menu_button.dart';

class GroupDetailsViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GroupDetailsViewAppBar({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      title: Row(
        children: [
          const CustomBackButton(),
          const SizedBox(width: 12),
          Expanded(
            child: BlocBuilder<GroupCubit, GroupState>(
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

                return Text(
                  name,
                  style: AppStyles.textStyle24.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        CustomMenuButton(groupModel: groupModel),
        const SizedBox(width: 6),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
