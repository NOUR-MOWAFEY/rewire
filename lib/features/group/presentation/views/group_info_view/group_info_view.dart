import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/view_background_container.dart';
import '../../../data/models/group_info_view_data.dart';
import 'widgets/group_info_view_app_bar.dart';
import 'widgets/group_info_view_body.dart';

class GroupInfoView extends StatelessWidget {
  const GroupInfoView({super.key, required this.dataModel});
  final GroupDataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: GroupInfoViewAppBar(groupModel: dataModel.groupModel),
      viewBody: BlocProvider.value(
        value: dataModel.membersCubit,
        child: GroupInfoViewBody(dataModel: dataModel),
      ),
    );
  }
}
