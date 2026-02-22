import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/services/firestore_service.dart';
import 'package:rewire/core/utils/service_locator.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/days_cubit/days_cubit.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_details_view_app_bar.dart';

import '../../../../core/widgets/view_background_container.dart';
import 'widgets/group_details_view_body.dart';

class GroupDetailsView extends StatelessWidget {
  const GroupDetailsView({super.key, required this.habitModel});
  final GroupModel habitModel;

  @override
  Widget build(BuildContext context) {
    return ViewBackGroundContainer(
      appBar: CustomDetailsViewAppBar(groupName: habitModel.title),
      viewBody: BlocProvider(
        create: (context) =>
            DaysCubit(getIt.get<FirestoreService>(), habitId: habitModel.id)
              ..listenToDays(),
        child: const GroupDetailsViewBody(),
      ),
    );
  }
}
