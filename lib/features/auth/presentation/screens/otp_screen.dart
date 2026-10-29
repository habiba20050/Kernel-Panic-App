import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/otp_code_field.dart';

/// Step two of the password reset: verify the six digit code that was mailed to
/// the user.
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.email = '', this.resetSeconds = 45});

  /// Address the code was sent to, echoed back in the sheet.
  final String email;

  /// Seconds before the "resend" action becomes available again.
  final int resetSeconds;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  late int _secondsLeft;
  String _code = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.resetSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _countdown {
    final int seconds = _secondsLeft % 60;
    final String padded = seconds.toString().padLeft(2, '0');
    return '0:$padded';
  }

  Future<void> _onVerify() async {
    if (_code.length < 6) return;
    setState(() => _isLoading = true);

    // TODO: call VerifyOtpUseCase
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.login);
  }

  void _onResend() {
    setState(() => _secondsLeft = widget.resetSeconds);
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'تأكيد الكود',
      subtitle: 'بعتنالك كود من 6 أرقام على بريدك الإلكتروني',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthBackButton(
            onPressed: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.forgotPassword),
          ),
          const SizedBox(height: 20),
          Text(
            'كود التحقق',
            textAlign: TextAlign.start,
            style: AppTextStyles.fieldLabel,
          ),
          if (widget.email.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              widget.email,
              textAlign: TextAlign.start,
              style: AppTextStyles.authMuted.copyWith(
                fontSize: 13.5,
                color: AppColors.hint,
              ),
            ),
          ],
          const SizedBox(height: 12),
          OtpCodeField(
            onChanged: (String value) => setState(() => _code = value),
            onCompleted: (String value) => setState(() => _code = value),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              if (_secondsLeft > 0)
                Text(
                  'إعادة الإرسال بعد $_countdown',
                  style: AppTextStyles.authMuted.copyWith(fontSize: 13.5),
                )
              else
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _onResend,
                  child: Text(
                    'إعادة إرسال الكود',
                    style: AppTextStyles.authLink.copyWith(fontSize: 13.5),
                  ),
                ),
              const Spacer(),
              if (_secondsLeft == 0)
                Text(
                  'الكود صلاحيته 10 دقائق',
                  style: AppTextStyles.authMuted.copyWith(fontSize: 12.5),
                ),
            ],
          ),
          const SizedBox(height: 22),
          AuthPrimaryButton(
            label: 'تحقق من الكود',
            onPressed: _code.length == 6 ? _onVerify : null,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 18),
          Center(
            child: TextButton(
              onPressed: () => context.go(AppRoutes.forgotPassword),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              child: Text(
                'تغيير البريد الإلكتروني',
                style: AppTextStyles.authLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
