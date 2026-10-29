import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import '../theme/app_colors.dart';

/// Full-bleed illustrated brand gradient shared by the splash screen and the
/// auth hero.
///
/// The illustrated gradient shipped with the design is drawn on top of a solid
/// brand gradient so that no gap is ever visible while the image decodes or on
/// screens with an unusual aspect ratio.
class BrandBackdrop extends StatelessWidget {
  const BrandBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.splashGradient),
      child: Image.asset(
        AppAssets.splashBackground,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        excludeFromSemantics: true,
      ),
    );
  }
}
