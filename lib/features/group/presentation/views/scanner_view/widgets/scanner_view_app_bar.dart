import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/custom_back_button.dart';

class ScannerViewAppBar extends StatelessWidget {
  const ScannerViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: EdgeInsets.symmetric(horizontal: 12),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,

          colors: [Color.fromARGB(220, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
        ),
      ),

      child: Column(
        children: [
          const SizedBox(height: 50),

          Row(
            children: [
              const CustomBackButton(color: Colors.black26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Scan Group QR',
                  style: AppStyles.textStyle24.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
