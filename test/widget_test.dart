import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kernel_panic_app/core/theme/app_theme.dart';
import 'package:kernel_panic_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:kernel_panic_app/features/splash/presentation/screens/splash_screen.dart';

void main() {
  testWidgets('splash renders the brand wordmark', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const SplashScreen(duration: Duration(days: 1)),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1200));

    expect(find.text('IT TEAM'), findsOneWidget);
    expect(find.byType(SplashScreen), findsOneWidget);

    // Disposing the tree cancels the splash navigation timer.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('onboarding starts on the first slide', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const OnboardingScreen()),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('التالي'), findsOneWidget);
    expect(find.textContaining('كورسات ومسارات تعلم'), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}
