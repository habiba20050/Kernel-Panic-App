import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Pill style page indicator used by the splash and onboarding screens.
///
/// The active step expands into a rounded bar; the rest stay as small dots.
/// Ordering follows the ambient [Directionality], so inside an RTL context the
/// first step is rendered on the right — exactly how the design reads.
class PageDotsIndicator extends StatelessWidget {
  const PageDotsIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor = AppColors.primary,
    this.inactiveColor = AppColors.indicatorInactive,
    this.dotSize = 7,
    this.activeWidth = 28,
    this.gap = 8,
    this.duration = const Duration(milliseconds: 260),
  });

  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double activeWidth;
  final double gap;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(count, (int index) {
        final bool isActive = index == currentIndex;

        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: index == 0 ? 0 : gap,
          ),
          child: AnimatedContainer(
            duration: duration,
            curve: Curves.easeOutCubic,
            width: isActive ? activeWidth : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
        );
      }),
    );
  }
}
