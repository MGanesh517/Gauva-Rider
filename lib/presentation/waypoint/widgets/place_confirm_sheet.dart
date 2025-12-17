import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/waypoint/provider/picked_address_fetcher_providers.dart';
import 'package:gauva_userapp/presentation/waypoint/widgets/app_card_sheet.dart';

import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../gen/assets.gen.dart';
import '../provider/pick_route_providers.dart';
import '../provider/way_point_list_providers.dart';
import 'place_result_item.dart';

class PlaceConfirmSheet extends ConsumerWidget {
  final LatLng location;
  final int index;
  const PlaceConfirmSheet({super.key, required this.location, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wayPointsState = ref.watch(wayPointListNotifierProvider);
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();
    return AppCardSheet(
      child: SafeArea(
        top: false,
        bottom: !isIos(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context).drag_map_adjust_location,

                style: context.titleMedium?.copyWith(fontSize: 19.sp),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(pickedAddressFetcherNotifierProvider(location));
                        return Expanded(
                          child: state.when(
                            // loading: () => Assets.lottie.loading.lottie(),
                            loading: () => const LoadingView(),
                            data: (address) => PlaceResultItem(
                              title: '',
                              subtitle: address.isNotEmpty ? address : AppLocalizations.of(context).no_address_found,
                              onPressed: null,
                              isDark: isDark,
                            ),
                            error: (error, stackTrace) => const Text(''),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Gap(28.h),
              Consumer(
                builder: (context, ref, _) {
                  final state = ref.watch(pickedAddressFetcherNotifierProvider(location));
                  final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);
                  return AppPrimaryButton(
                    isDisabled: state.isLoading,
                    onPressed: () {
                      wayPointNotifier.updateWayPoint(
                        index: index,
                        name: name(context, wayPointsState.length, index),
                        address: state.value ?? '',
                        location: location,
                      );
                      Navigator.pop(context);
                    },
                    child: ref
                        .watch(pickRouteNotifierProvider)
                        .when(
                          pickupPoint: (position) =>
                              Text(AppLocalizations.of(context).confirm_pickup, style: buttonTextStyle(context)),
                          dropPoint: (position) =>
                              Text(AppLocalizations.of(context).confirm_destination, style: buttonTextStyle(context)),
                          stopPoint: (position) => Text('Confirm stop', style: buttonTextStyle(context)),
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle? buttonTextStyle(BuildContext context) => context.bodyMedium?.copyWith(color: Colors.white);
}

String name(BuildContext context, int length, int index) {
  if (length == 2) {
    switch (index) {
      case 0:
        return 'Pick-up';
      case 1:
        return 'Destination';
    }
  } else {
    switch (index) {
      case 0:
        return 'Pick-up';
      case 1:
        return 'Stop point';
      case 2:
        return 'Destination';
    }
  }
  return '';
}
