import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../data/models/group_model.dart';
import '../../view_model/days_cubit/days_cubit.dart';
import '../../view_model/group_cubit/group_cubit.dart';
import '../../view_model/members_cubit/members_cubit.dart';
import 'widgets/group_details_view_app_bar.dart';

import '../../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              MembersCubit()..listenToAllMembers(groupModel.id),
        ),
        BlocProvider(
          create: (context) => DaysCubit(
            getIt.get<FirestoreService>(),
            groupModel.id,
            groupCubit: context.read<GroupCubit>(),
          )..listenToDays(),
        ),
      ],
      child: ViewBackGroundContainer(
        appBar: GroupDetailsViewAppBar(groupModel: groupModel),
        viewBody: const GroupDetailsViewBody(),
      ),
    );
  }
}
