import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import '../../../core/theme/color_palette.dart';
import '../../../core/widgets/country_code_bottom_sheet.dart';
import '../../account_page/provider/select_country_provider.dart';
import '../../waypoint/provider/selected_loc_text_field_providers.dart';
import '../provider/home_map_providers.dart';

class HomeMapAppbar extends StatelessWidget {
  final bool isDark;
  const HomeMapAppbar({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF397098), Color(0xFF942FAF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Content area
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [locationAndCountrySelection(context), const Gap(12), searchBar(context)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget locationAndCountrySelection(BuildContext context) => Consumer(
    builder: (context, ref, _) {
      final homeMapState = ref.watch(homeMapNotifierProvider);
      final state = ref.watch(selectedCountry);
      return Row(
        children: [
          Assets.images.locationPin.image(height: 24, width: 24, fit: BoxFit.fill),
          const Gap(4),
          Expanded(
            child: Text(
              homeMapState.address ?? AppLocalizations.of(context).fetching_address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
            ),
          ),
          Gap(isIos() ? 0 : 16),
          isIos()
              ? const SizedBox.shrink()
              : InkWell(
                  onTap: () {
                    debugPrint('--------------button tapped');
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      builder: (context) => const CountryCodeBottomSheet(selectCountryCode: false),
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 95,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .12),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: state.selectedLang == null
                        ? const SizedBox.shrink()
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildNetworkImage(
                                imageUrl: state.selectedLang!.flag,
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                                errorIconSize: 16,
                              ),
                              const Gap(8),
                              Expanded(
                                child: Text(
                                  state.selectedLang?.code ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: context.bodyMedium?.copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Gap(8),
                              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                              const Gap(8),
                            ],
                          ),
                  ),
                ),
        ],
      );
    },
  );

  Widget searchBar(BuildContext context) => Consumer(
    builder: (context, WidgetRef ref, _) => InkWell(
      onTap: () {
        ref.read(selectedLocTextFieldNotifierProvider.notifier).resetState();
        NavigationService.pushNamed(AppRoutes.searchDestinationPage);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: context.surface, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF687387), size: 24),
            const Gap(8),
            Expanded(
              child: Text(
                AppLocalizations().search_destination,
                style: context.bodyMedium?.copyWith(
                  color: const Color(0xFF687387),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              height: 16,
              width: 1,
              color: const Color(0xFFD7DAE0),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Assets.images.locationPin.image(height: 20, width: 18, fit: BoxFit.fill, color: ColorPalette.primary50),
          ],
        ),
      ),
    ),
  );
}
