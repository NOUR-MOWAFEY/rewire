import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_colors.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/views/widgets/add_people_container_item.dart';

class CustomAccordion extends StatelessWidget {
  const CustomAccordion({super.key});

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
          header: Text(
            'Members',
            style: AppStyles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          content: AddPeopleContainerItem(),
          rightIcon: Icon(FontAwesomeIcons.angleDown, size: 18),
          paddingBetweenOpenSections: 12,
        ),
      ],
    );
  }
}
