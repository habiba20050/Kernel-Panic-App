import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/onboarding_slide.dart';

/// Local, hard-coded source for the onboarding copy.
///
/// Kept behind a small class so the content can later be moved to a remote
/// flag or a localised catalogue without touching the presentation layer.
class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  List<OnboardingSlide> loadSlides() => const [
        OnboardingSlide(
          title: 'تعلّم IT و Software\nخطوة بخطوة',
          description:
              'كورسات ومسارات تعلم من فريق Kernel Panic، تابع تقدمك واحصل '
              'على شهادتك.',
          illustration: AppAssets.onboardingCourses,
          actionLabel: 'التالي',
        ),
        OnboardingSlide(
          title: 'إيفينتس وورش عمل\nوتذكرتك QR',
          description:
              'اكتشف الإيفينتس القادمة، سجّل بضغطة واحدة، وكوّن جدولك الخاص.',
          illustration: AppAssets.onboardingEvents,
          actionLabel: 'التالي',
        ),
        OnboardingSlide(
          title: 'خدمات IT وسوفتوير\nواستشارة مجانية',
          description:
              'اطلب خدمة أو احجز استشارة مع مهندسينا، وتابع حالة طلبك والدعم '
              'الفني.',
          illustration: AppAssets.onboardingServices,
          actionLabel: 'ابدأ الآن',
        ),
      ];
}
