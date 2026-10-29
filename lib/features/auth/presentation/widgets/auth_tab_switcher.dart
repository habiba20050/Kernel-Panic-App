import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Two-segment pill switch used to move between the login and sign-up forms.
///
/// Segment order follows the ambient [Directionality], so labels are supplied in
/// reading order: the first label sits on the right in Arabic.
class AuthTabSwitcher extends StatelessWidget {
  const AuthTabSwitcher({
    super.key,
    required this.labels,
    required this.currentIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.authTabTrack,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: List<Widget>.generate(labels.length, (int index) {
          final bool isActive = index == currentIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(13),
                  boxShadow: isActive
                      ? const [
                          BoxShadow(
                            color: Color(0x140B1020),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: isActive
                      ? AppTextStyles.tabLabel
                      : AppTextStyles.tabLabel.copyWith(
                          color: AppColors.inkMuted,
                          fontWeight: FontWeight.w600,
                        ),
                  child: Text(labels[index]),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
