import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/google_glyph.dart';

/// Visual weight of the "continue with Google" button.
enum AuthSocialVariant {
  /// White button with a hairline border, used on the login form.
  light,

  /// Solid ink button, used as the primary path on the sign-up form.
  dark,
}

/// "Continue with Google" button with the painted brand glyph.
class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AuthSocialVariant.light,
  });

  final String label;
  final VoidCallback? onPressed;
  final AuthSocialVariant variant;

  @override
  Widget build(BuildContext context) {
    final bool isDark = variant == AuthSocialVariant.dark;

    return Container(
      height: isDark ? 56 : 52,
      decoration: BoxDecoration(
        color: isDark ? AppColors.ink : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: isDark ? null : Border.all(color: AppColors.authHairline),
        boxShadow: isDark
            ? const [
                BoxShadow(
                  color: Color(0x33070A14),
                  blurRadius: 24,
                  offset: Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _GlyphBadge(isDark: isDark),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: AppTextStyles.authButtonLabel.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.white : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlyphBadge extends StatelessWidget {
  const _GlyphBadge({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : AppColors.googleBadge,
        shape: BoxShape.circle,
      ),
      child: const GoogleGlyph(size: 11, color: AppColors.googleInk),
    );
  }
}
