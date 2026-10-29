import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

/// Step one of the password reset: collect the account email so a verification
/// code can be sent to it.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // TODO: call RequestPasswordResetUseCase
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    context.push(
      Uri(
        path: AppRoutes.otp,
        queryParameters: <String, String>{'email': _emailController.text.trim()},
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'نسيت كلمة المرور؟',
      subtitle: 'اكتب بريدك وهنبعتلك كود لإعادة التعيين',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthBackButton(
            onPressed: () => context.canPop()
                ? context.pop()
                : context.go(AppRoutes.login),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextField(
                  label: 'البريد الإلكتروني',
                  hint: 'name@email.com',
                  controller: _emailController,
                  validator: Validators.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onSubmit(),
                  leadingIcon: Icons.mail_outline_rounded,
                  autofocus: true,
                ),
                const SizedBox(height: 20),
                AuthPrimaryButton(
                  label: 'إرسال الكود',
                  onPressed: _onSubmit,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _ResetHint(),
        ],
      ),
    );
  }
}

/// Quiet note that sets the delivery expectation after the code is requested.
class _ResetHint extends StatelessWidget {
  const _ResetHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.authTabTrack,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.mark_email_unread_outlined,
            size: 18,
            color: AppColors.inkMuted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'الكود بيوصل خلال دقيقة تقريبًا. لو ملقتهوش، بص في مجلد '
              'الرسائل غير المرغوب فيها.',
              style: AppTextStyles.authMuted.copyWith(
                fontSize: 12.5,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
