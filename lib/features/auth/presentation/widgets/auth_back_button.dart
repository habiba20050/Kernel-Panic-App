import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

/// Circular back affordance used by the sheets that sit outside the
/// login / sign-up tabs (forgot password and OTP verification).
///
/// The arrow follows the ambient text direction, so it points to the right in
/// Arabic and to the left in English.
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({
    super.key,
    required this.onPressed,
    this.semanticLabel = 'رجوع',
  });

  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Material(
        color: AppColors.authTabTrack,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Semantics(
            button: true,
            label: semanticLabel,
            child: const SizedBox(
              width: 40,
              height: 40,
              child: Icon(
                // Mirrored by the framework: points left in English, right in
                // Arabic, which is "back" in both.
                Icons.arrow_back_rounded,
                size: 20,
                color: AppColors.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
