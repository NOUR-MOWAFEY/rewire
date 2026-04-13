import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/home_view/widgets/join_group_form_buttons.dart';
import 'package:rewire/features/home/presentation/views/scanner_view/scanner_view.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_underline_text_field.dart';

class JoinGroupForm extends StatefulWidget {
  const JoinGroupForm({super.key});

  @override
  State<JoinGroupForm> createState() => _JoinGroupFormState();
}

class _JoinGroupFormState extends State<JoinGroupForm> {
  late TextEditingController groupId;
  late TextEditingController groupPassword;

  @override
  void initState() {
    super.initState();
    groupId = TextEditingController();
    groupPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    groupId.dispose();
    groupPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Join Group', style: AppStyles.textStyle24),

            const Spacer(),

            IconButton(
              onPressed: () {
                final joinGroupCubit = context.read<JoinGroupCubit>();
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ScannerView(joinGroupCubit: joinGroupCubit),
                  ),
                );
              },
              icon: const Icon(FontAwesomeIcons.qrcode),
            ),
          ],
        ),
        const SizedBox(height: 20),

        CustomUnderlineTextField(hintText: 'Group ID', controller: groupId),

        const SizedBox(height: 12),

        CustomUnderlineTextField(
          hintText: 'Password',
          textInputType: TextInputType.visiblePassword,
          controller: groupPassword,
        ),

        const SizedBox(height: 24),

        const Spacer(),

        JoinGroupFormButtons(groupId: groupId, groupPassword: groupPassword),
      ],
    );
  }
}
