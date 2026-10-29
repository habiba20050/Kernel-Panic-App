import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:kernel_panic_app/core/routing/app_router.dart';
import 'package:kernel_panic_app/core/theme/app_theme.dart';
import 'package:kernel_panic_app/features/auth/presentation/screens/otp_screen.dart';
import 'package:kernel_panic_app/features/auth/presentation/widgets/auth_social_button.dart';
import 'package:kernel_panic_app/features/auth/presentation/widgets/otp_code_field.dart';

/// Pumps the real router at [location] so the tests exercise the same routes
/// the app uses.
Future<void> pumpAt(WidgetTester tester, String location) async {
  final GoRouter router = AppRouter.router;
  router.go(location);
  await tester.pumpWidget(
    MaterialApp.router(theme: AppTheme.light, routerConfig: router),
  );
  // The screens animate their focus glow; a bounded pump is enough.
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  testWidgets('login shows the sign-in form', (WidgetTester tester) async {
    await pumpAt(tester, AppRoutes.login);

    expect(find.text('أهلاً بيك من تاني'), findsOneWidget);
    expect(find.text('تسجيل الدخول'), findsNWidgets(2)); // tab + button
    expect(find.text('نسيت كلمة المرور؟'), findsOneWidget);
    expect(find.byType(AuthSocialButton), findsOneWidget);
    expect(find.text('متابعة كزائر'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('the sign-up tab switches forms', (WidgetTester tester) async {
    await pumpAt(tester, AppRoutes.login);

    await tester.tap(find.text('حساب جديد'));
    await tester.pumpAndSettle(const Duration(milliseconds: 400));

    expect(find.text('إنشاء حساب جديد'), findsOneWidget);
    expect(find.text('عندك حساب بالفعل؟'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('forgot password hands the email to the OTP step', (
    WidgetTester tester,
  ) async {
    await pumpAt(tester, AppRoutes.forgotPassword);

    expect(find.text('نسيت كلمة المرور؟'), findsOneWidget);

    await tester.enterText(
      find.byType(TextFormField).first,
      'habiba@kernelpanic.dev',
    );
    final Finder submit = find.text('إرسال الكود');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(OtpScreen), findsOneWidget);
    // The form stays mounted underneath, so the address shows up twice.
    expect(find.text('habiba@kernelpanic.dev'), findsNWidgets(2));

    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('six digits unlock the verify action', (
    WidgetTester tester,
  ) async {
    await pumpAt(tester, '${AppRoutes.otp}?email=habiba@kernelpanic.dev');

    expect(find.byType(OtpCodeField), findsOneWidget);
    expect(find.text('habiba@kernelpanic.dev'), findsOneWidget);
    expect(find.textContaining('إعادة الإرسال بعد'), findsOneWidget);

    final Finder boxes = find.byType(TextField);
    expect(boxes, findsNWidgets(6));
    for (int i = 0; i < 6; i++) {
      await tester.enterText(boxes.at(i), '${i + 1}');
      await tester.pump(const Duration(milliseconds: 60));
    }
    await tester.pump(const Duration(milliseconds: 100));

    final Finder verify = find.text('تحقق من الكود');
    await tester.ensureVisible(verify);
    await tester.tap(verify);
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(milliseconds: 400));

    // A correct code returns the user to the sign-in form.
    expect(find.text('أهلاً بيك من تاني'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}
