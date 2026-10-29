import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Rounded square checkbox used for "remember me" and the terms agreement.
class AuthCheckbox extends StatelessWidget {
  const AuthCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 22,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(size * 0.32),
          border: value
              ? null
              : Border.all(color: AppColors.indicatorInactive, width: 1.5),
        ),
        child: value
            ? Icon(Icons.check_rounded, size: size * 0.72, color: AppColors.white)
            : null,
      ),
    );
  }
}
