import 'package:flutter/material.dart';

/// Brand palette taken from the design system.
///
/// Every screen (splash, onboarding, auth, home) should read its colours
/// from here instead of hard-coding hex values.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF0553EE);
  static const Color primaryLight = Color(0xFF0A67FC);
  static const Color primaryDark = Color(0xFF0146E4);
  static const Color accent = Color(0xFF00C2FF);

  // Light surfaces
  static const Color canvas = Color(0xFFF6F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFEDEFF4);

  // Text
  static const Color ink = Color(0xFF0B1020);
  static const Color inkMuted = Color(0xFF5B6478);
  static const Color indicatorInactive = Color(0xFFC9D3E8);
  static const Color white = Color(0xFFFFFFFF);

  // Splash (dark) surfaces
  static const Color splashTop = Color(0xFF070A14);
  static const Color splashMid = Color(0xFF081133);
  static const Color splashBottom = Color(0xFF052DA1);
  static const Color splashAccent = Color(0xFF3DB8FF);
  static const Color splashCaption = Color(0xFFB9C6E6);
  static const Color splashDotInactive = Color(0xFF5B72B7);

  // Elevation
  static const Color shadow = Color(0x1A0B1020);

  // Auth surfaces
  static const Color authTabTrack = Color(0xFFEFF3FA);
  static const Color authFieldFill = Color(0xFFF4F7FD);
  static const Color authFieldGlow = Color(0xFFE1EDFF);
  static const Color authHairline = Color(0xFFE4E8F0);
  static const Color hint = Color(0xFF8A93A6);

  /// Google brand blue, used by the painted "G" glyph.
  static const Color googleBlue = Color(0xFF4285F4);

  /// Single-colour "G" mark used on the auth social buttons.
  static const Color googleInk = Color(0xFF0040C0);

  /// Tinted disc that sits behind the "G" mark on the light social button.
  static const Color googleBadge = Color(0xFFEEF3FC);

  /// Filled call-to-action used on the auth screens.
  static const LinearGradient authGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF119BFF), Color(0xFF0247E5)],
  );

  /// Filled primary gradient used by the onboarding call-to-action.
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primaryDark],
  );

  /// Fallback gradient for the splash screen (the design also ships an
  /// illustrated background image on top of it).
  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [splashTop, splashMid, splashBottom],
    stops: [0.0, 0.32, 1.0],
  );
}
