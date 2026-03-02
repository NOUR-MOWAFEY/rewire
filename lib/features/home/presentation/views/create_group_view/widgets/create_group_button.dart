import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/widgets/custom_button.dart';
import 'package:rewire/features/home/presentation/view_model/create_group_cubit/create_group_cubit.dart';

class CreategroupButton extends StatelessWidget {
  const CreategroupButton({
    super.key,
    required this.groupNameKey,
    required this.groupNameController,
  });

  final GlobalKey<FormState> groupNameKey;
  final TextEditingController groupNameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      child: CustomButton(
        title: 'Create Group',
        onPressed: () async {
          if (!groupNameKey.currentState!.validate()) return;
          context.read<CreateGroupCubit>().createGroup(
            groupNameController.text.trim(),
            '',
          );
        },
      ),
    );
  }
}
