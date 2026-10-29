import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Eye toggle that sits on the trailing side of a password field.
class AuthVisibilityToggle extends StatelessWidget {
  const AuthVisibilityToggle({
    super.key,
    required this.obscured,
    required this.onPressed,
  });

  final bool obscured;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      tooltip: obscured ? 'إظهار كلمة المرور' : 'إخفاء كلمة المرور',
      icon: Icon(
        obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        size: 22,
        color: AppColors.inkMuted,
      ),
    );
  }
}
