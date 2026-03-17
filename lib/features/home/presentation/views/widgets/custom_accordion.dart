import 'dart:developer';

import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/core/widgets/custom_loading.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/members_cubit/members_cubit.dart';
import 'package:rewire/features/home/presentation/views/create_group_view/widgets/members_list_view.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_member_bottom_sheet.dart';

class CustomAccordion extends StatelessWidget {
  const CustomAccordion({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Accordion(
      scaleWhenAnimating: false,

      headerPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),

      headerBackgroundColor: AppColors.secondary,

      contentBackgroundColor: AppColors.alertDialogColor,

      contentBorderWidth: 0,
      headerBorderWidth: 0,

      headerBorderRadius: 18,
      contentBorderRadius: 18,

      disableScrolling: true,

      children: [
        AccordionSection(
          header: Row(
            children: [
              Text(
                'Members',
                style: AppStyles.textStyle16.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),

              const Spacer(),

              CustomButton(
                height: 35,
                width: 60,

                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.alertDialogColor,
                    builder: (context) => BlocProvider(
                      create: (context) => MembersCubit(),
                      child: AddMemberBottomSheet(groupModel: groupModel),
                    ),
                  );
                },

                child: Icon(FontAwesomeIcons.plus, color: AppColors.white),
              ),

              const SizedBox(width: 12),
            ],
          ),

          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: BlocBuilder<MembersCubit, MembersState>(
              builder: (context, state) {
                if (state is MembersError) {
                  log(state.errMassage);

                  return const Center(
                    child: Text(
                      'Failed to load members',
                      style: AppStyles.textStyle18,
                    ),
                  );
                }

                if (state is MembersLoaded) {
                  return MembersListView(
                    users: state.members,
                    groupModel: groupModel,
                  );
                }
                return const CustomLoading(size: 28);
              },
            ),
          ),
          rightIcon: const Icon(FontAwesomeIcons.angleDown, size: 18),
          paddingBetweenOpenSections: 12,
        ),
      ],
    );
  }
}
