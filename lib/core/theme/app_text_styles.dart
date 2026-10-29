import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Font families bundled with the app (see `pubspec.yaml`).
class AppFonts {
  AppFonts._();

  /// Rounded Arabic + Latin display face used for headings and buttons.
  static const String display = 'BalooBhaijaan2';

  /// Arabic + Latin face used for paragraphs and small labels.
  static const String body = 'Cairo';

  /// Latin only face used for the brand wordmark.
  static const String latin = 'Poppins';
}

/// Typography scale shared by the splash and onboarding screens.
///
/// Sizes follow the design at a 390pt wide reference viewport.
class AppTextStyles {
  AppTextStyles._();

  /// Onboarding headline ("تعلّم IT و Software خطوة بخطوة").
  static const TextStyle onboardingTitle = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 29,
    fontWeight: FontWeight.w800,
    height: 1.3,
    color: AppColors.ink,
    letterSpacing: -0.2,
  );

  /// Supporting paragraph under the headline.
  static const TextStyle onboardingBody = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15.5,
    fontWeight: FontWeight.w400,
    height: 1.75,
    color: AppColors.inkMuted,
  );

  /// "تخطي" action in the top bar.
  static const TextStyle skipAction = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  /// "1 / 3" step counter in the top bar.
  static const TextStyle stepCounter = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.inkMuted,
  );

  /// Label inside the filled call-to-action button.
  static const TextStyle buttonLabel = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  /// "KERNEL PANIC" wordmark on the splash screen.
  static const TextStyle wordmark = TextStyle(
    fontFamily: AppFonts.latin,
    fontSize: 29.5,
    fontWeight: FontWeight.w700,
    letterSpacing: 4.15,
    height: 1.1,
    color: AppColors.white,
  );

  /// "IT TEAM" caption under the wordmark.
  static const TextStyle wordmarkCaption = TextStyle(
    fontFamily: AppFonts.latin,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 4.7,
    height: 1.1,
    color: AppColors.splashCaption,
  );

  /// Auth hero headline sitting on the dark gradient.
  static const TextStyle authTitle = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 25.2,
    fontWeight: FontWeight.w800,
    height: 1.3,
    letterSpacing: -0.1,
    color: AppColors.white,
  );

  /// Auth hero subtitle under [authTitle].
  static const TextStyle authSubtitle = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 13.7,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.splashCaption,
  );

  /// Label rendered above an auth input.
  static const TextStyle fieldLabel = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.ink,
  );

  /// Placeholder shown inside an empty auth input.
  static const TextStyle fieldHint = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.hint,
  );

  /// Text the user types into an auth input.
  static const TextStyle fieldValue = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.ink,
  );

  /// Login / sign-up segmented tab label.
  static const TextStyle tabLabel = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 15.5,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );

  /// Muted helper text and secondary links.
  static const TextStyle authMuted = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: AppColors.inkMuted,
  );

  /// Small inline link such as "نسيت كلمة المرور؟".
  static const TextStyle authLink = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  /// Emphasised inline link used for the terms and conditions.
  static const TextStyle authLinkStrong = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 13.5,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  /// Small caption such as "أو" or the guest entry point.
  static const TextStyle authCaption = TextStyle(
    fontFamily: AppFonts.body,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.hint,
  );

  /// Label inside the auth primary button.
  static const TextStyle authButtonLabel = TextStyle(
    fontFamily: AppFonts.display,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  /// Base text theme applied to `ThemeData`.
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: AppFonts.display,
      fontSize: 48,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
    headlineLarge: TextStyle(
      fontFamily: AppFonts.display,
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
    headlineMedium: TextStyle(
      fontFamily: AppFonts.display,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    headlineSmall: TextStyle(
      fontFamily: AppFonts.display,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    titleMedium: TextStyle(
      fontFamily: AppFonts.body,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.ink,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppFonts.body,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.ink,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppFonts.body,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.inkMuted,
    ),
    labelLarge: TextStyle(
      fontFamily: AppFonts.body,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.white,
    ),
  );
}
