import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/page_dots_indicator.dart';
import '../widgets/app_logo_badge.dart';
import '../widgets/splash_background.dart';
import '../widgets/splash_wordmark.dart';

/// Animated brand splash that hands over to the onboarding flow.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, this.duration = const Duration(seconds: 3)});

  /// How long the splash stays visible before navigating away.
  final Duration duration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _badgeOpacity;
  late final Animation<double> _badgeScale;
  late final Animation<double> _wordmarkOpacity;
  late final Animation<Offset> _wordmarkOffset;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..forward();

    _badgeOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
    _badgeScale = Tween<double>(begin: 0.88, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );
    _wordmarkOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );
    _wordmarkOffset = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _navigationTimer = Timer(widget.duration, _goToOnboarding);
  }

  void _goToOnboarding() {
    if (!mounted) return;
    context.go(AppRoutes.onboarding);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashTop,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const SplashBackground(),
            Column(
              children: [
                const Spacer(flex: 17),
                FadeTransition(
                  opacity: _badgeOpacity,
                  child: ScaleTransition(
                    scale: _badgeScale,
                    child: const AppLogoBadge(),
                  ),
                ),
                const SizedBox(height: 39),
                FadeTransition(
                  opacity: _wordmarkOpacity,
                  child: SlideTransition(
                    position: _wordmarkOffset,
                    child: const SplashWordmark(),
                  ),
                ),
                const Spacer(flex: 13),
                SafeArea(
                  top: false,
                  minimum: const EdgeInsets.only(bottom: 63.5),
                  child: const PageDotsIndicator(
                    count: 3,
                    currentIndex: 0,
                    activeColor: AppColors.splashAccent,
                    inactiveColor: AppColors.splashDotInactive,
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
