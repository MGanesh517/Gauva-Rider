import 'package:flutter/material.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/utils/color_palette.dart';
import '../../../data/models/onboarding_item.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';

class OnboardingFormBuilder {
  final int onboardingItemIndex;

  const OnboardingFormBuilder({required this.onboardingItemIndex});

  Widget buildHeader(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 40),
    child: onBoardingItem(context).image.image(height: 302, width: double.infinity, fit: BoxFit.fill),
  );

  Widget buildFooter(BuildContext context) => buildInformationFooter(context);

  Widget buildInformationFooter(BuildContext context) => Column(
    children: [
      Text(
        onBoardingItem(context).title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: context.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
      ),
      const SizedBox(height: 4),
      Text(
        onBoardingItem(context).subTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: context.headlineSmall?.copyWith(color: ColorPalette.primary50),
      ),
      const SizedBox(height: 8),
      Text(
        onBoardingItem(context).description,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: context.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
    ],
  );

  OnBoardingItem onBoardingItem(BuildContext context) => onboardingItems(context)[onboardingItemIndex];
}

List<OnBoardingItem> onboardingItems(BuildContext context) => [
  OnBoardingItem(
    image: Assets.images.onboarding1,
    title: AppLocalizations.of(context).welcomeTitle,
    subTitle: AppLocalizations.of(context).rideYourWay,
    description: AppLocalizations.of(context).welcomeSubtitle,
  ),
  OnBoardingItem(
    image: Assets.images.onboarding2,
    title: AppLocalizations.of(context).safeSecure,
    subTitle: AppLocalizations.of(context).safetyPriority,
    description: AppLocalizations.of(context).rideFeatures,
  ),
  OnBoardingItem(
    image: Assets.images.onboarding3,
    title: AppLocalizations.of(context).affordableConvenient,
    subTitle: AppLocalizations.of(context).smartRideSavings,
    description: AppLocalizations.of(context).rideBookingEase,
  ),
];
