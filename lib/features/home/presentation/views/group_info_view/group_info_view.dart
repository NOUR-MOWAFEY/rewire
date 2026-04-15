import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/view_background_container.dart';
import 'package:rewire/features/home/data/models/group_info_view_data.dart';
import 'package:rewire/features/home/presentation/views/group_info_view/widgets/group_info_view_app_bar.dart';
import 'package:rewire/features/home/presentation/views/group_info_view/widgets/group_info_view_body.dart';

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
