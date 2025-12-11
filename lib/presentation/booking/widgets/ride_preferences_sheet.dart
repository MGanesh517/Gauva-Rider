import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/gen/assets.gen.dart';
import 'package:gauva_userapp/presentation/booking/provider/ride_preference_provider.dart';

import '../../../core/widgets/buttons/app_close_button.dart';
import '../../../core/widgets/buttons/app_primary_button.dart';
import '../../../generated/l10n.dart';
import '../provider/ride_services_providers.dart';
import '../provider/selection_providers.dart';
import 'ride_preference_checkable_item.dart';

class RidePreferencesSheet extends StatefulWidget {
  final bool isDark;
  const RidePreferencesSheet({super.key, required this.isDark});

  @override
  State<RidePreferencesSheet> createState() => _RidePreferencesSheetState();
}

class _RidePreferencesSheetState extends State<RidePreferencesSheet> {
  @override
  Widget build(BuildContext context) => SafeArea(
    bottom: !isIos(),
    child: Container(
        height: context.height * 0.62,
        margin: EdgeInsets.only(bottom: isIos() ? 8.h : 0),
        decoration: BoxDecoration(
          color: context.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16))
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildHeader(context),
    
                          Consumer(builder: (context, ref, _) {
                            final prefState = ref.watch(ridePreferenceProvider);
                            return prefState.maybeWhen(
                              success: (list) {
    
                                if(list.isEmpty){
                                  return Center(child: Text(AppLocalizations.of(context).no_service_available, style: context.bodyMedium?.copyWith(color: Colors.red),),);
                                }
                                return Column(
                                  children: list.mapIndexed((index, e) => Consumer(
                                    builder: (context, ref, _) {
                                      final state = ref.watch(selectedRideNotifierProvider);
                                      final notifier = ref.read(selectedRideNotifierProvider.notifier);
                                      return RidePreferenceCheckableItem(
                                        title: e.name?.capitalize().replaceAll('_', ' ') ?? '',
                                        icon: Ionicons.time_outline,
                                        fee: 0,
                                        currency: '₹',
                                        isSelected: state.contains(e),
                                        onChanged: (p0) {
                                          setState(() {
                                            if (p0) {
                                              notifier.addRide(e);
                                            } else {
                                              notifier.removeRide(e);
                                            }
                                          });
                                        }, isDark: widget.isDark,
                                      );
                                    },
                                  ))
                                      .toList(),
                                );
                              },
                              orElse: () => const SizedBox.shrink(),
                            );
                          }),
                          const Divider(),
                        ],
                      ),
                    ),
                  ),
    
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
                    child: Consumer(builder: (context, ref, _) {
                      final notifier = ref.read(selectedRideNotifierProvider.notifier);
                      final rideServiceStateNotifier = ref.read(rideServiceFilterNotiferProvider.notifier);
                      final riderServicesNotifier = ref.read(rideServicesNotifierProvider.notifier);
                      return AppPrimaryButton(
                        onPressed: () {
                          final serviceFilterState = rideServiceStateNotifier.updateServiceOptionIds(notifier.getRideIds());
                          riderServicesNotifier.getRideServices(riderServiceFilter: serviceFilterState);
                          NavigationService.pop();
                        },
                        child: Text(AppLocalizations.of(context).apply, style: context.bodyMedium?.copyWith(color: Colors.white),),
                      );
                    }),
                  )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child:
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AppCloseButton(
                      onPressed: () {
                        NavigationService.pop();
                      },
                    ),
                  ),
                ),)
            ],
          ),
        ),
      ),
  );

  IconData serviceIcon(String value) {
    switch (value) {
      case 'luggage':
        return Ionicons.bag;
      case 'pet':
        return Ionicons.paw;
      case 'roundTrip':
        return Ionicons.refresh;
      default:
        return Ionicons.bag;
    }
  }

  String serviceName(String value) {
    switch (value) {
      case 'luggage':
        return 'Luggage';
      case 'pet':
        return 'Pet';
      case 'round_trip':
        return 'Round Trip';
      default:
        return '';
    }
  }

  Widget buildHeader(BuildContext context) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Assets.images.preference.image(height: 60.h, width: 60.w, fit: BoxFit.fill),
              Gap(12.h),
              Text(
                AppLocalizations.of(context).ride_preferences,
                style: context.headlineSmall?.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700, ),
              ),
              const Gap(8),
              Text(
                AppLocalizations.of(context).ride_preferences_description,
                textAlign: TextAlign.center,
                style: context.headlineSmall?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400, color: const Color(0xFF687387)),
              ),
            ],
          ),
        ),
      );
}

enum Options { luggage, pet, roundTrip }
