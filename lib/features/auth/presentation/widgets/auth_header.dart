import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Dark gradient hero that sits above the auth sheet: brand mark, headline and
/// supporting line.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.height = 240,
    this.logoSize = 71,
    this.topPadding = 50,
    this.titleGap = 12,
    this.subtitleGap = 4,
    this.titleSize,
  });

  final String title;
  final String subtitle;

  /// Distance from the very top of the screen to the bottom of the hero.
  final double height;

  final double logoSize;

  /// Distance from the top of the safe area to the brand mark.
  final double topPadding;

  final double titleGap;
  final double subtitleGap;

  /// Overrides the headline size when a screen needs a tighter hero.
  final double? titleSize;

  @override
  Widget build(BuildContext context) {
    final double topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: height + topInset,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: topPadding + topInset),
          _LogoBadge(size: logoSize),
          SizedBox(height: titleGap),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: titleSize == null
                  ? AppTextStyles.authTitle
                  : AppTextStyles.authTitle.copyWith(fontSize: titleSize),
            ),
          ),
          SizedBox(height: subtitleGap),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.authSubtitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoBadge extends StatelessWidget {
  const _LogoBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(size * 0.26),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33020810),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Image.asset(AppAssets.logoMark, fit: BoxFit.contain),
    );
  }
}
