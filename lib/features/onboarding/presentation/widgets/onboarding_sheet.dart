import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/page_dots_indicator.dart';
import '../../domain/entities/onboarding_slide.dart';
import 'onboarding_action_button.dart';

/// White bottom sheet that carries the copy, the call-to-action and the
/// page indicator.
class OnboardingSheet extends StatelessWidget {
  const OnboardingSheet({
    super.key,
    required this.slide,
    required this.currentIndex,
    required this.totalSteps,
    required this.onAction,
  });

  final OnboardingSlide slide;
  final int currentIndex;
  final int totalSteps;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 30,
            spreadRadius: 2,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 36),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 36, 28, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 320),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.08),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _SlideCopy(
                  key: ValueKey<String>(slide.title),
                  slide: slide,
                ),
              ),
              const SizedBox(height: 27),
              Row(
                children: [
                  PageDotsIndicator(
                    count: totalSteps,
                    currentIndex: currentIndex,
                  ),
                  const Spacer(),
                  OnboardingActionButton(
                    label: slide.actionLabel,
                    onPressed: onAction,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SlideCopy extends StatelessWidget {
  const _SlideCopy({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // Stretch so every paragraph gets the full sheet width; otherwise the
      // block shrinks to its longest line and the copy drifts away from the
      // right edge instead of hugging it.
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          slide.title,
          textAlign: TextAlign.start,
          style: AppTextStyles.onboardingTitle,
        ),
        const SizedBox(height: 11),
        Text(
          slide.description,
          textAlign: TextAlign.start,
          style: AppTextStyles.onboardingBody,
        ),
      ],
    );
  }
}
