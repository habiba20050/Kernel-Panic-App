import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/auth_checkbox.dart';
import '../widgets/auth_or_divider.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_social_button.dart';
import '../widgets/auth_tab_switcher.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_visibility_toggle.dart';

/// Email + password sign-in form.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // TODO: call LoginUseCase
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'أهلاً بيك من تاني',
      subtitle: 'سجّل دخولك وكمّل رحلتك معانا',
      logoSize: 71.5,
      headerTopPadding: 50.5,
      titleGap: 21.5,
      subtitleGap: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthTabSwitcher(
            labels: const ['تسجيل الدخول', 'حساب جديد'],
            currentIndex: 0,
            onChanged: (int index) {
              if (index == 1) context.go(AppRoutes.register);
            },
          ),
          const SizedBox(height: 16),
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
                  textInputAction: TextInputAction.next,
                  leadingIcon: Icons.mail_outline_rounded,
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'كلمة المرور',
                  hint: '••••••••',
                  controller: _passwordController,
                  validator: Validators.password,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onLogin(),
                  leadingIcon: Icons.lock_outline_rounded,
                  trailing: AuthVisibilityToggle(
                    obscured: _obscurePassword,
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                _OptionsRow(
                  rememberMe: _rememberMe,
                  onRememberChanged: (bool value) =>
                      setState(() => _rememberMe = value),
                  onForgotPassword: () =>
                      context.push(AppRoutes.forgotPassword),
                ),
                const SizedBox(height: 16),
                AuthPrimaryButton(
                  label: 'تسجيل الدخول',
                  onPressed: _onLogin,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.5),
          const AuthOrDivider(label: 'أو'),
          const SizedBox(height: 19.5),
          AuthSocialButton(
            label: 'المتابعة باستخدام Google',
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () => context.go(AppRoutes.home),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
              ),
              child: Text(
                'متابعة كزائر',
                style: AppTextStyles.authMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionsRow extends StatelessWidget {
  const _OptionsRow({
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotPassword,
  });

  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onRememberChanged(!rememberMe),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthCheckbox(value: rememberMe, onChanged: onRememberChanged),
              const SizedBox(width: 8),
              Text('تذكّرني', style: AppTextStyles.authMuted),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onForgotPassword,
          child: Text(
            'نسيت كلمة المرور؟',
            style: AppTextStyles.authLink,
          ),
        ),
      ],
    );
  }
}
