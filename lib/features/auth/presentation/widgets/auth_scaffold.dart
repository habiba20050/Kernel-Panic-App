import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/brand_backdrop.dart';
import 'auth_header.dart';

/// Shell shared by every auth screen: a dark gradient hero with the brand mark
/// and a rounded white sheet that carries the interactive content.
///
/// The gradient is painted behind the whole screen (and clipped by the sheet),
/// so the visible ramp matches the splash screen exactly.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.headerHeight = 240,
    this.logoSize = 71,
    this.headerTopPadding = 50,
    this.titleGap = 12,
    this.subtitleGap = 4,
    this.titleSize,
    this.sheetPadding = const EdgeInsets.fromLTRB(24, 22, 24, 28),
  });

  final String title;
  final String subtitle;
  final Widget child;

  final double headerHeight;
  final double logoSize;
  final double headerTopPadding;
  final double titleGap;
  final double subtitleGap;
  final double? titleSize;
  final EdgeInsets sheetPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const BrandBackdrop(),
            Column(
              children: [
                AuthHeader(
                  title: title,
                  subtitle: subtitle,
                  height: headerHeight,
                  logoSize: logoSize,
                  topPadding: headerTopPadding,
                  titleGap: titleGap,
                  subtitleGap: subtitleGap,
                  titleSize: titleSize,
                ),
                Expanded(
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(38),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1F070A14),
                          blurRadius: 28,
                          spreadRadius: 1,
                          offset: Offset(0, -6),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: sheetPadding,
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
