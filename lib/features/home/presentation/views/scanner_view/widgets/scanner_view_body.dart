import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewire/core/utils/app_styles.dart';
import 'package:rewire/core/utils/show_toastification.dart';
import 'package:rewire/core/widgets/custom_circular_loading.dart';
import 'package:rewire/features/home/presentation/view_model/join_group_cubit/join_group_cubit.dart';
import 'package:rewire/features/home/presentation/views/scanner_view/widgets/qr_scanner.dart';
import 'package:rewire/features/home/presentation/views/scanner_view/widgets/scanner_view_app_bar.dart';

class ScannerViewBody extends StatelessWidget {
  const ScannerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JoinGroupCubit, JoinGroupState>(
      listener: (context, state) {
        if (state is JoinGroupJoined) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (state is JoinGroupRequestFailed) {
          ShowToastification.failure(context, state.errMessage);
        }
      },
      builder: (context, state) {
        // if loading
        if (state is JoinGroupLoading) {
          return const CustomCircularLoading();
        }

        // if failure: while waiting 3 seconds
        if (state is JoinGroupRequestFailed) {
          return const Column(
            mainAxisAlignment: .center,
            children: [
              CustomCircularLoading(),

              SizedBox(height: 16),

              Text('Wait and try again', style: AppStyles.textStyle22),
            ],
          );
        }

        return const Stack(
          children: [
            // Scanner
            QrScanner(),

            // Appbar
            ScannerViewAppBar(),
          ],
        );
      },
    );
  }
}
