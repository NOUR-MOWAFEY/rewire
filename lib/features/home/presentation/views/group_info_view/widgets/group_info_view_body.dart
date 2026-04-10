import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/members_list_view.dart';

class GroupInfoViewBody extends StatelessWidget {
  const GroupInfoViewBody({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ListView(
        children: [
          const SizedBox(height: 12),

          // ID Section
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: groupModel.joinCode)).then((
                value,
              ) {
                if (!context.mounted) return;
                ShowToastification.popUp(context, 'Copied to clipboard');
              });
            },

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('ID: ', style: AppStyles.textStyle24),
                Flexible(
                  child: Text(
                    groupModel.joinCode,
                    style: AppStyles.textStyle24,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Members Section
          Text(
            'Members (${groupModel.members.length})',
            style: AppStyles.textStyle18.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          BlocBuilder<MembersCubit, MembersState>(
            builder: (context, state) {
              if (state is MembersLoading) {
                return CustomLoading(size: 26);
              } else if (state is MembersLoaded) {
                return MembersListView(
                  users: state.members,
                  groupModel: groupModel,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  isMembersRemovable: false,
                );
              } else if (state is MembersError) {
                return Center(child: Text(state.errMassage));
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
