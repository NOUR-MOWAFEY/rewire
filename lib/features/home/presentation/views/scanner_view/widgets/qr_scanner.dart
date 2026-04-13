import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';

class QrScanner extends StatelessWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      tapToFocus: true,

      onDetect: (result) async {
        final groupId = result.barcodes.isNotEmpty
            ? result.barcodes.first.rawValue
            : null;

        if (groupId != null) {
          await context.read<JoinGroupCubit>().joinGroupViaId(groupId: groupId);
        }
      },
    );
  }
}
