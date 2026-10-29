import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/datasources/onboarding_local_datasource.dart';
import '../../domain/entities/onboarding_slide.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/onboarding_illustration.dart';
import '../widgets/onboarding_sheet.dart';

/// Three step, right-to-left onboarding carousel shown after the splash.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingSlide> _slides =
      const OnboardingLocalDataSource().loadSlides();
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  bool get _isLastSlide => _currentIndex == _slides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  void _onActionPressed() {
    if (_isLastSlide) {
      _finish();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
    );
  }

  void _finish() => context.go(AppRoutes.login);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            SafeArea(
              bottom: false,
              minimum: const EdgeInsets.only(top: 41),
              child: OnboardingHeader(
                currentStep: _currentIndex + 1,
                totalSteps: _slides.length,
                onSkip: _finish,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                physics: const BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemBuilder: (BuildContext context, int index) {
                  return OnboardingIllustration(slide: _slides[index]);
                },
              ),
            ),
            OnboardingSheet(
              slide: _slides[_currentIndex],
              currentIndex: _currentIndex,
              totalSteps: _slides.length,
              onAction: _onActionPressed,
            ),
          ],
        ),
      ),
    );
  }
}
