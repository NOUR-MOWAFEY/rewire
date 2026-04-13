import 'package:flutter/material.dart';
import 'package:rewire/features/home/presentation/views/scanner_view/widgets/scanner_view_body.dart';

class ScannerView extends StatelessWidget {
  const ScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ScannerViewBody());
  }
}
