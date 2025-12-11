import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/data/services/local_storage_service.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/presentation/account_page/view/account_page.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/color_palette.dart';
import '../../../core/utils/exit_app_dialogue.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../generated/l10n.dart';
import '../provider/onboarding_providers.dart';
import '../widgets/onboarding_form_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Local controller
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose controller
    super.dispose();
  }

  void goToNextPage() {
    final currentIndex = ref.read(onboardingNotifierProvider);
    if (currentIndex < 2) {
      _pageController.nextPage(duration: const Duration(milliseconds: 1000), curve: Curves.easeInOut);
      ref.read(onboardingNotifierProvider.notifier).nextPage(); // Update state
    } else {
      LocalStorageService().completeOnboarding();
      NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
    }
  }

  void onSkip() {
    LocalStorageService().completeOnboarding();
    NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final onboardingIndex = ref.watch(onboardingNotifierProvider);

    return ExitAppWrapper(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Assets.images.rideIn.image(height: 37.h, width: 50.w),
                    Image.asset("assets/onboarding.jpg", height: 60.h, width: 50.w),
                    const Spacer(),
                    countrySelector(),
                    Gap(8.w),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: onSkip,
                      child: Text(AppLocalizations.of(context).skip),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              /// PageView taking most of the screen
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3,
                  onPageChanged: (index) {
                    ref.read(onboardingNotifierProvider.notifier).setIndex(index);
                  },
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: OnboardingFormBuilder(onboardingItemIndex: index).buildHeader(context)),
                        SizedBox(height: 24.h),
                        OnboardingFormBuilder(onboardingItemIndex: index).buildFooter(context),
                      ],
                    ),
                  ),
                ),
              ),

              /// Smooth Page Indicator - right before the button
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: AnimatedSmoothIndicator(
                  activeIndex: onboardingIndex,
                  count: 3,
                  duration: const Duration(milliseconds: 500),
                  effect: const WormEffect(
                    dotHeight: 8,
                    radius: 50,
                    dotColor: ColorPalette.primary94,
                    activeDotColor: ColorPalette.primary20,
                  ),
                ),
              ),

              /// Button
              Padding(
                padding: EdgeInsets.only(bottom: 24.h, left: 16.w, right: 16.w),
                child: AppPrimaryButton(
                  onPressed: goToNextPage,
                  child: onboardingIndex == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            getButtonText(context, onboardingIndex),
                            SizedBox(width: 8.w),
                            const Icon(Ionicons.arrow_forward_circle_outline, size: 21, color: Colors.white),
                          ],
                        )
                      : getButtonText(context, onboardingIndex),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getButtonText(BuildContext context, int index) {
    final TextStyle? textStyle = context.labelMedium?.copyWith(color: Colors.white);
    if (index == 0) return Text(AppLocalizations.of(context).letsGo, style: textStyle);
    if (index == 1) return Text(AppLocalizations.of(context).proceedNext, style: textStyle);
    if (index == 2) return Text(AppLocalizations.of(context).getStarted, style: textStyle);
    return const Text('');
  }
}
