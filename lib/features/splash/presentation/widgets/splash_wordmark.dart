import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Two-tone "KERNEL PANIC" wordmark with the "IT TEAM" caption underneath.
class SplashWordmark extends StatelessWidget {
  const SplashWordmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: 'KERNEL ',
            style: AppTextStyles.wordmark,
            children: const [
              TextSpan(
                text: 'PANIC',
                style: TextStyle(color: AppColors.splashAccent),
              ),
            ],
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          semanticsLabel: 'Kernel Panic',
        ),
        const SizedBox(height: 16),
        Text(
          'IT TEAM',
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: AppTextStyles.wordmarkCaption,
        ),
      ],
    );
  }
}
