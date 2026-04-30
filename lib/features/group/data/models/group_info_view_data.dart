import '../../presentation/view_model/group_cubit/group_cubit.dart';
import '../../presentation/view_model/members_cubit/members_cubit.dart';
import 'group_model.dart';

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
