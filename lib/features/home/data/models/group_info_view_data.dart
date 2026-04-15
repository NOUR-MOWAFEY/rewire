import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';

class GroupDataModel {
  final GroupModel groupModel;
  final MembersCubit membersCubit;
  final GroupCubit groupCubit;
  GroupDataModel({
    required this.groupModel,
    required this.membersCubit,
    required this.groupCubit,
  });
}
