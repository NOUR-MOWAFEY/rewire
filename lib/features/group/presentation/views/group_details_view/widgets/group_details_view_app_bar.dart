import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/group_cubit/group_cubit.dart';
import '../../groups_view/widgets/group_item_image.dart';
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
          const CustomBackButton(color: Colors.transparent),
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

                return Row(
                  children: [
                    Hero(
                      tag: 'group_image_${groupModel.id}',
                      child: GroupItemImage(groupModel: groupModel, size: 40),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Hero(
                        tag: 'group_name_${groupModel.id}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            name,
                            style: AppStyles.textStyle24.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
