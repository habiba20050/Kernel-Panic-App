import 'package:flutter/material.dart';

import '../../domain/entities/onboarding_slide.dart';

/// Illustration that sits between the top bar and the bottom sheet.
class OnboardingIllustration extends StatelessWidget {
  const OnboardingIllustration({super.key, required this.slide});

  final OnboardingSlide slide;

  /// Native aspect ratio of the exported illustration assets (1600 x 1280).
  static const double _aspectRatio = 1600 / 1280;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: Image.asset(
            slide.illustration,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            excludeFromSemantics: true,
          ),
        ),
      ),
    );
  }
}
