import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/features/home/data/models/group_model.dart';
import 'package:rewire/features/home/presentation/view_model/group_cubit/group_cubit.dart';
import 'package:rewire/features/home/presentation/views/group_settings_view/widgets/group_data_fields.dart';
import 'package:rewire/features/home/presentation/views/widgets/custom_update_button.dart';

class GroupDataForm extends StatefulWidget {
  const GroupDataForm({super.key, required this.groupModel});

  final GroupModel groupModel;

  @override
  State<GroupDataForm> createState() => _GroupDataFormState();
}

class _GroupDataFormState extends State<GroupDataForm> {
  late final TextEditingController _groupNameController;
  late final TextEditingController _groupPasswordController;

  @override
  void initState() {
    super.initState();
    _groupNameController = TextEditingController();
    _groupPasswordController = TextEditingController();

    _groupNameController.text = widget.groupModel.name;
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _groupPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // text fields
        GroupDataFields(
          groupNameController: _groupNameController,
          groupPasswordController: _groupPasswordController,
        ),

        // update button
        BlocBuilder<GroupCubit, GroupState>(
          builder: (context, state) => context.read<GroupCubit>().isLoading
              ? CustomUpdateButton(title: 'Loading ..', isEnabled: false)
              : CustomUpdateButton(
                  onPressed: () async => _updateButtonOnPressed(context),
                ),
        ),
      ],
    );
  }

  // update button method
  Future<void> _updateButtonOnPressed(BuildContext context) async {
    await context
        .read<GroupCubit>()
        .updateGroupData(
          widget.groupModel.id,

          _groupNameController.text.isEmpty ? null : _groupNameController.text,

          _groupPasswordController.text.isEmpty
              ? null
              : _groupPasswordController.text,
        )
        .then((value) {
          if (!mounted) return;
          _groupPasswordController.clear();
        });
  }
}
