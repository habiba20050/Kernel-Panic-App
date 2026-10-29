import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Top bar of the onboarding flow: step counter on the start side and the
/// "تخطي" (skip) action on the end side.
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.onSkip,
  });

  final int currentStep;
  final int totalSteps;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 0, 28, 0),
      child: Row(
        children: [
          Text(
            '$currentStep / $totalSteps',
            style: AppTextStyles.stepCounter,
            textDirection: TextDirection.rtl,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onSkip,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Text('تخطي', style: AppTextStyles.skipAction),
            ),
          ),
        ],
      ),
    );
  }
}
