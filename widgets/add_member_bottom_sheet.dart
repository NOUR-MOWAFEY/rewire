import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:rewire/features/group/data/models/group_model.dart';
import 'package:rewire/features/profile_view/presentation/views/widgets/bottom_sheet_handle.dart';
import 'add_member_button_sheet_buttons.dart';

class AddMemberBottomSheet extends StatefulWidget {
  const AddMemberBottomSheet({super.key, required this.groupModel});
  final GroupModel groupModel;

  @override
  State<AddMemberBottomSheet> createState() => _AddMemberBottomSheetState();
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet> {
  late TextEditingController memberEmailController;

  @override
  void initState() {
    memberEmailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    memberEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 18),

      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const BottomSheetHandle(),

              const SizedBox(height: 18),

              const Row(
                children: [
                  SizedBox(width: 12),
                  Text('Add Member', style: AppStyles.textStyle22),
                ],
              ),

              const SizedBox(height: 26),

              CustomTextFormField(
                title: 'Email',
                controller: memberEmailController,
                icon: FontAwesomeIcons.solidEnvelope,
                isLastOne: false,
                border: false,
              ),

              const SizedBox(height: 18),

              // Buttons
              AddMemberBottomSheetButtons(
                memberEmailController: memberEmailController,
                groupModel: widget.groupModel,
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
