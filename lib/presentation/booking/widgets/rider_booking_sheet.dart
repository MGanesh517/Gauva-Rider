import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/booking/provider/order_providers.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';

import '../../../core/utils/helpers.dart';
import '../provider/ride_services_providers.dart';
import '../provider/selection_providers.dart';

class RideBookingSheet extends ConsumerStatefulWidget {
  const RideBookingSheet({super.key});

  @override
  ConsumerState<RideBookingSheet> createState() => _RideBookingSheetState();
}

class _RideBookingSheetState extends ConsumerState<RideBookingSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final filter = ref.read(rideServiceFilterNotiferProvider);
      ref.read(rideServicesNotifierProvider.notifier).getAvailableServicesForRoute(riderServiceFilter: filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final riderServiceState = ref.watch(rideServicesNotifierProvider);
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final selectedService = ref.watch(carTypeNotifierProvider).selectedCarType;

    // Calculate dynamic height based on number of services
    final serviceCount = riderServiceState.whenOrNull(success: (data) => data.data?.servicesList?.length ?? 0) ?? 0;

    // Calculate approximate height needed
    // Drag handle: ~20h, Each service card: ~70h, Button: ~74h, Padding: ~16h
    final screenHeight = MediaQuery.of(context).size.height;
    final dragHandleHeight = 20.h;
    final buttonHeight = 74.h; // 50h button + 24h padding
    final serviceCardHeight = 70.h; // Approximate height per card
    final spacing = 8.h; // Spacing between cards
    final contentPadding = 16.h;

    final totalContentHeight =
        dragHandleHeight +
        (serviceCount * serviceCardHeight) +
        ((serviceCount > 0 ? serviceCount - 1 : 0) * spacing) +
        buttonHeight +
        contentPadding;

    // Calculate initial size as percentage of screen height
    final calculatedSize = (totalContentHeight / screenHeight).clamp(0.25, 0.9);
    final minSize = calculatedSize.clamp(0.25, 0.9);

    return DraggableScrollableSheet(
      initialChildSize: calculatedSize,
      minChildSize: minSize,
      maxChildSize: 0.9, // Maximum 90%
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [BoxShadow(color: Color(0x3F0E275D), blurRadius: 20, offset: Offset(2, 4))],
        ),
        child: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(color: const Color(0xFFD7DAE0), borderRadius: BorderRadius.circular(10)),
                ),
              ),
              // Scrollable Content - use Expanded to fill available space, button stays at bottom
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [_buildServiceList(context, riderServiceState, ref, isDark)],
                    ),
                  ),
                ),
              ),
              // Fixed Bottom Button Bar - always at bottom
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: Offset(0, -2))],
                ),
                child: _buildBookButton(context, selectedService, isDark),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList(BuildContext context, dynamic state, WidgetRef ref, bool isDark) => Builder(
    builder: (_) => state.when(
      initial: () => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(child: Text(AppLocalizations.of(context).initializing)),
      ),
      loading: () => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: const Center(child: LoadingView()),
      ),
      error: (e) => Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Center(child: Text(e.message)),
      ),
      success: (data) {
        final list = data.data?.servicesList ?? [];
        if (list.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(child: Text(AppLocalizations.of(context).no_service_available)),
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: list.map<Widget>((service) {
            final selectedService = ref.watch(carTypeNotifierProvider).selectedCarType;
            // More robust selection check - compare both id and serviceId
            final isSelected =
                selectedService != null &&
                ((selectedService.id != null && selectedService.id == service.id) ||
                    (selectedService.serviceId != null &&
                        selectedService.serviceId == service.serviceId &&
                        selectedService.serviceId.toString().isNotEmpty));
            return _buildServiceCard(context, service, isSelected, ref, isDark);
          }).toList(),
        );
      },
    ),
  );

  Widget _buildServiceCard(BuildContext context, dynamic service, bool isSelected, WidgetRef ref, bool isDark) {
    final notifier = ref.read(carTypeNotifierProvider.notifier);
    final serviceName = (service.displayName ?? service.name ?? 'SERVICE').toUpperCase();

    // Get icon - check iconUrl first, if null/empty then use icon (emoji)
    final iconEmoji = service.icon;
    final iconUrl = (service.iconUrl != null && service.iconUrl.toString().trim().isNotEmpty)
        ? service.iconUrl
        : ((service.logo != null && service.logo.toString().trim().isNotEmpty) ? service.logo : null);

    // Get price - prefer costAfterCoupon (finalTotal), then totalFare, then serviceFare
    final price = service.costAfterCoupon ?? service.totalFare ?? service.serviceFare ?? service.minimumFare ?? 0.0;

    // Get capacity - prefer capacity, then personCapacity
    final capacity = service.capacity ?? service.personCapacity;

    return InkWell(
      onTap: () => notifier.selectCar(service),
      child: isSelected
          ? Container(
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [const Color(0xFF1469B5), const Color(0xFF942FAF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1469B5).withOpacity(0.3), blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                child: Row(
                  children: [
                    // Service Icon - check iconUrl first, if null/empty then show icon (emoji)
                    if (iconUrl != null && iconUrl.toString().trim().isNotEmpty)
                      Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        child: buildNetworkImage(
                          imageUrl: iconUrl.toString(),
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.contain,
                        ),
                      )
                    else if (iconEmoji != null && iconEmoji.toString().trim().isNotEmpty)
                      Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        child: Text(iconEmoji.toString(), style: TextStyle(fontSize: 32.sp)),
                      )
                    else
                      Container(
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        child: Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
                      ),
                    Gap(10.w),
                    // Service Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                serviceName,
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black),
                              ),
                              if (capacity != null) ...[
                                Gap(4.w),
                                Icon(Ionicons.person, size: 12.sp, color: Colors.black87),
                                Gap(2.w),
                                Text(
                                  capacity.toString(),
                                  style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                                ),
                              ],
                            ],
                          ),
                          if (service.description != null && service.description.toString().isNotEmpty) ...[
                            Gap(2.h),
                            Text(
                              service.description.toString(),
                              style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                            ),
                          ],
                          Gap(2.h),
                          Row(
                            children: [
                              Text(
                                service.estimatedArrival ?? '3 mins away',
                                style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                              ),
                              Text(
                                ' • Drop ${_getEstimatedDropTime(service)}',
                                style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Price
                    Text(
                      '₹${price.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Row(
                children: [
                  // Service Icon - check iconUrl first, if null/empty then show icon (emoji)
                  if (iconUrl != null && iconUrl.toString().trim().isNotEmpty)
                    Container(
                      width: 40.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      child: buildNetworkImage(
                        imageUrl: iconUrl.toString(),
                        width: 40.w,
                        height: 40.h,
                        fit: BoxFit.contain,
                      ),
                    )
                  else if (iconEmoji != null && iconEmoji.toString().trim().isNotEmpty)
                    Container(
                      width: 40.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      child: Text(iconEmoji.toString(), style: TextStyle(fontSize: 32.sp)),
                    )
                  else
                    Container(
                      width: 40.w,
                      height: 40.h,
                      alignment: Alignment.center,
                      child: Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
                    ),
                  Gap(10.w),
                  // Service Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              serviceName,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700, color: Colors.black),
                            ),
                            if (capacity != null) ...[
                              Gap(4.w),
                              Icon(Ionicons.person, size: 12.sp, color: Colors.black87),
                              Gap(2.w),
                              Text(
                                capacity.toString(),
                                style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                              ),
                            ],
                          ],
                        ),
                        if (service.description != null && service.description.toString().isNotEmpty) ...[
                          Gap(2.h),
                          Text(
                            service.description.toString(),
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                          ),
                        ],
                        Gap(2.h),
                        Row(
                          children: [
                            Text(
                              service.estimatedArrival ?? '3 mins away',
                              style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                            ),
                            Text(
                              ' • Drop ${_getEstimatedDropTime(service)}',
                              style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Price
                  Text(
                    '₹${price.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.black),
                  ),
                ],
              ),
            ),
    );
  }

  String _getEstimatedDropTime(dynamic service) {
    final now = DateTime.now();
    final arrivalMins = int.tryParse(service.estimatedArrival?.replaceAll(RegExp(r'[^0-9]'), '') ?? '3') ?? 3;
    final dropTime = now.add(Duration(minutes: arrivalMins + 7));
    var hour = dropTime.hour;
    final minute = dropTime.minute.toString().padLeft(2, '0');
    final amPm = hour >= 12 ? 'pm' : 'am';
    if (hour > 12) hour = hour - 12;
    if (hour == 0) hour = 12;
    return '$hour:$minute $amPm';
  }

  Widget _buildBookButton(BuildContext context, dynamic selectedService, bool isDark) => Consumer(
    builder: (context, ref, _) {
      final notifier = ref.read(createOrderNotifierProvider.notifier);

      Future<void> handleOrderCreation() async {
        final selectedService = ref.read(carTypeNotifierProvider);
        final bookingData = ref.read(rideServiceFilterNotiferProvider);

        if (selectedService.selectedCarType == null) {
          showNotification(message: AppLocalizations.of(context).select_service);
          return;
        }

        final service = selectedService.selectedCarType;
        final serviceId = service?.id ?? service?.serviceId;

        if (serviceId == null) {
          showNotification(message: 'Please select a valid service');
          return;
        }

        final data = {
          'pickup_location': [bookingData.pickupLocation.first, bookingData.pickupLocation.last],
          'drop_location': [bookingData.dropLocation.first, bookingData.dropLocation.last],
          'wait_location': bookingData.waitLocation.isNotEmpty
              ? [bookingData.waitLocation.first, bookingData.waitLocation.last]
              : [],
          'service_option_ids': bookingData.serviceOptionIds,
          'coupon_code': bookingData.couponCode,
          'pickup_address': bookingData.pickupAddress,
          'drop_address': bookingData.dropAddress,
          'wait_address': bookingData.waitAddress,
          'service_id': serviceId,
        };

        await notifier.createOrder(orderData: data);
      }

      return Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF397098), Color(0xFF942FAF)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: handleOrderCreation,
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: ref.watch(createOrderNotifierProvider).whenOrNull(loading: () => true) ?? false
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF397098), Color(0xFF942FAF)],
                        ).createShader(bounds),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    )
                  : Text(
                      'Book Now',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
            ),
          ),
        ),
      );
    },
  );
}
