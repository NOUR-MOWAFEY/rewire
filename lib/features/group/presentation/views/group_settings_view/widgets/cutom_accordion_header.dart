import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../data/models/group_model.dart';
import '../../../view_model/members_cubit/members_cubit.dart';
import 'add_member_bottom_sheet.dart';

class CutomAccordionHeader extends StatelessWidget {
  const CutomAccordionHeader({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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

          child: const Icon(FontAwesomeIcons.plus, color: AppColors.white),
        ),

        const SizedBox(width: 12),
      ],
    );
  }
}
