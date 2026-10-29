import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Filled, rounded call-to-action used at the bottom of the onboarding sheet.
///
/// The chevron sits on the trailing side so that inside an RTL layout it points
/// forward (to the left). `Icons.chevron_left_rounded` is a direction-aware
/// glyph, so it is pinned to LTR to stop Flutter from mirroring it.
class OnboardingActionButton extends StatelessWidget {
  const OnboardingActionButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  static const double _height = 56;
  static const double _radius = 15;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330553EE),
            blurRadius: 22,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(_radius),
          child: Container(
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: 26),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTextStyles.buttonLabel),
                const SizedBox(width: 2),
                const Icon(
                  Icons.chevron_left_rounded,
                  size: 26,
                  color: AppColors.white,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
