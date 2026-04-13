import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rewire/features/home/presentation/views/scanner_view/widgets/scanner_view_app_bar.dart';

class ScannerViewBody extends StatelessWidget {
  const ScannerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scanner
        MobileScanner(
          tapToFocus: true,
          onDetect: (result) {
            log(result.barcodes.first.rawValue.toString());
            // context.pop();
          },
        ),

        // Appbar
        const ScannerViewAppBar(),
      ],
    );
  }
}
