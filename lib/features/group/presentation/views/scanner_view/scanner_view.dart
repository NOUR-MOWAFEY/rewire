import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/join_group_cubit/join_group_cubit.dart';
import 'widgets/scanner_view_body.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key, required this.joinGroupCubit});
  final JoinGroupCubit joinGroupCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: joinGroupCubit,
        child: const ScannerViewBody(),
      ),
    );
  }
}
