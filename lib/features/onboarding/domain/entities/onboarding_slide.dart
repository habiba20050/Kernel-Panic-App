import 'package:flutter/foundation.dart';

/// A single step of the onboarding carousel.
@immutable
class OnboardingSlide {
  const OnboardingSlide({
    required this.title,
    required this.description,
    required this.illustration,
    required this.actionLabel,
  });

  /// Headline shown in the bottom sheet (supports line breaks).
  final String title;

  /// Supporting paragraph under the headline.
  final String description;

  /// Asset path of the illustration displayed above the sheet.
  final String illustration;

  /// Label of the call-to-action button for this step.
  final String actionLabel;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingSlide &&
          runtimeType == other.runtimeType &&
          title == other.title;

  @override
  int get hashCode => title.hashCode;
}
