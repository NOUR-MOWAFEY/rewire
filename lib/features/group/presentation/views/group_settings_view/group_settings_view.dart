import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/view_background_container.dart';
import '../../../data/models/group_info_view_data.dart';
import 'widgets/delete_group_button.dart';
import 'widgets/group_settings_view_body.dart';

class GroupSettingsView extends StatelessWidget {
  const GroupSettingsView({super.key, required this.groupDataModel});

  final GroupDataModel groupDataModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 28,
          top: 12,
        ),
        child: DeleteGroupButton(groupModel: groupDataModel.groupModel),
      ),

      viewBody: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: groupDataModel.membersCubit),
          BlocProvider.value(
            value: groupDataModel.groupCubit
              ..getJoinCode(groupDataModel.groupModel.id),
          ),
        ],
        child: GroupSettingsViewBody(groupModel: groupDataModel.groupModel),
      ),
    );
  }
}
