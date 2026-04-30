import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'custom_accordion_body.dart';
import 'cutom_accordion_header.dart';

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
          header: CutomAccordionHeader(groupModel: groupModel),

          content: CustomAccordionBody(groupModel: groupModel),

          rightIcon: const Icon(FontAwesomeIcons.angleDown, size: 18),

          paddingBetweenOpenSections: 12,
        ),
      ],
    );
  }
}
