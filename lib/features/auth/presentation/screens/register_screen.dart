import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
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

/// Account creation form.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _acceptedTerms = false;
  bool _showTermsError = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    final bool formValid = _formKey.currentState!.validate();
    final bool termsValid = _acceptedTerms;
    if (!termsValid) setState(() => _showTermsError = true);
    if (!formValid || !termsValid) return;

    setState(() => _isLoading = true);

    // TODO: call RegisterUseCase
    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'إنشاء حساب جديد',
      subtitle: 'انضم لمجتمع Kernel Panic في دقيقة',
      headerHeight: 208,
      logoSize: 63.5,
      headerTopPadding: 44,
      titleGap: 17.5,
      subtitleGap: 2,
      titleSize: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthTabSwitcher(
            labels: const ['تسجيل الدخول', 'حساب جديد'],
            currentIndex: 1,
            onChanged: (int index) {
              if (index == 0) context.go(AppRoutes.login);
            },
          ),
          const SizedBox(height: 14),
          AuthSocialButton(
            label: 'التسجيل باستخدام Google',
            variant: AuthSocialVariant.dark,
            onPressed: () {},
          ),
          const SizedBox(height: 17.5),
          const AuthOrDivider(label: 'أو بالبريد الإلكتروني'),
          const SizedBox(height: 12),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AuthTextField(
                  hint: 'الاسم بالكامل',
                  controller: _nameController,
                  validator: (String? value) =>
                      Validators.required(value, fieldName: 'الاسم'),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  leadingIcon: Icons.person_outline_rounded,
                  autofocus: true,
                ),
                const SizedBox(height: 13),
                AuthTextField(
                  hint: 'البريد الإلكتروني',
                  controller: _emailController,
                  validator: Validators.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  leadingIcon: Icons.mail_outline_rounded,
                ),
                const SizedBox(height: 13),
                AuthTextField(
                  hint: 'كلمة المرور (8 أحرف على الأقل)',
                  controller: _passwordController,
                  validator: Validators.password,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _onRegister(),
                  leadingIcon: Icons.lock_outline_rounded,
                  trailing: AuthVisibilityToggle(
                    obscured: _obscurePassword,
                    onPressed: () => setState(
                      () => _obscurePassword = !_obscurePassword,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _TermsRow(
            value: _acceptedTerms,
            hasError: _showTermsError,
            onChanged: (bool value) => setState(() {
              _acceptedTerms = value;
              if (value) _showTermsError = false;
            }),
          ),
          const SizedBox(height: 13),
          AuthPrimaryButton(
            label: 'إنشاء حساب',
            onPressed: _onRegister,
            isLoading: _isLoading,
          ),
          const SizedBox(height: 15.5),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('عندك حساب بالفعل؟', style: AppTextStyles.authMuted),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.go(AppRoutes.login),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: Text(
                      'سجّل دخولك',
                      style: AppTextStyles.authLink.copyWith(fontSize: 14.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TermsRow extends StatelessWidget {
  const _TermsRow({
    required this.value,
    required this.hasError,
    required this.onChanged,
  });

  final bool value;
  final bool hasError;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(!value),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AuthCheckbox(value: value, onChanged: onChanged),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    style: AppTextStyles.authMuted.copyWith(fontSize: 13.5),
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'أوافق على ',
                        style: AppTextStyles.authMuted.copyWith(fontSize: 13.5),
                      ),
                      TextSpan(
                        text: 'الشروط والأحكام',
                        style: AppTextStyles.authLinkStrong,
                      ),
                      TextSpan(
                        text: ' و',
                        style: AppTextStyles.authMuted.copyWith(fontSize: 13.5),
                      ),
                      TextSpan(
                        text: 'سياسة الخصوصية',
                        style: AppTextStyles.authLinkStrong,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(
            'لازم توافق على الشروط والأحكام الأول',
            textAlign: TextAlign.start,
            style: AppTextStyles.authLinkStrong.copyWith(
              color: AppColors.primaryDark,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
