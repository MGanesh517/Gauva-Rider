import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/core/utils/network_image.dart';
import 'package:gauva_userapp/generated/l10n.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/intercity/provider/intercity_service_providers.dart';
import 'package:gauva_userapp/data/models/intercity_service_type.dart';

class SharePoolingSelectionPage extends ConsumerStatefulWidget {
  const SharePoolingSelectionPage({super.key});

  @override
  ConsumerState<SharePoolingSelectionPage> createState() => _SharePoolingSelectionPageState();
}

class _SharePoolingSelectionPageState extends ConsumerState<SharePoolingSelectionPage> {
  @override
  void initState() {
    super.initState();
    // Fetch intercity service types on page load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(intercityServiceNotifierProvider.notifier).getIntercityServiceTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final intercityState = ref.watch(intercityServiceNotifierProvider);
    final selectedService = intercityState.selectedServiceType;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Choose Vehicle',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildServiceList(context, intercityState.serviceListState, ref, isDark)),
            // Fixed Bottom Button Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isDark ? Colors.black : Colors.white,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: Offset(0, -2))],
              ),
              child: _buildContinueButton(context, selectedService, isDark),
            ),
          ],
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
        // data is List<IntercityServiceType>
        final list = data is List ? data : [];
        if (list.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(child: Text(AppLocalizations.of(context).no_service_available)),
          );
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: list.map<Widget>((service) {
              final isSelected = ref.watch(intercityServiceNotifierProvider).selectedServiceType?.id == service.id;
              return _buildServiceCard(context, service, isSelected, ref, isDark);
            }).toList(),
          ),
        );
      },
    ),
  );

  Widget _buildServiceCard(
    BuildContext context,
    IntercityServiceType service,
    bool isSelected,
    WidgetRef ref,
    bool isDark,
  ) {
    final notifier = ref.read(intercityServiceNotifierProvider.notifier);
    final serviceName = (service.displayName ?? service.vehicleType ?? 'SERVICE').toUpperCase();

    // Get icon - use imageUrl from IntercityServiceType
    final iconUrl = service.imageUrl;

    // Get price - use totalPrice from IntercityServiceType
    final price = service.totalPrice ?? 0.0;

    // Get capacity - use maxSeats from IntercityServiceType
    final capacity = service.maxSeats;

    return InkWell(
      onTap: () => notifier.selectServiceType(service),
      child: isSelected
          ? Container(
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [const Color(0xFF1469B5), const Color(0xFF942FAF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1469B5).withOpacity(0.3), blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              padding: EdgeInsets.all(2), // Border width
              child: Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    // Service Icon - prefer imageUrl, if null or empty then show dummy image
                    if (iconUrl != null && iconUrl.toString().trim().isNotEmpty)
                      buildNetworkImage(
                        imageUrl: iconUrl.toString(),
                        width: 40.w,
                        height: 40.h,
                        fit: BoxFit.contain,
                        errorWidget: Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
                      )
                    else
                      Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
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
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              if (capacity != null) ...[
                                Gap(4.w),
                                Icon(Ionicons.person, size: 12.sp, color: isDark ? Colors.white70 : Colors.black87),
                                Gap(2.w),
                                Text(
                                  capacity.toString(),
                                  style: TextStyle(fontSize: 12.sp, color: isDark ? Colors.white70 : Colors.black87),
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
                        ],
                      ),
                    ),
                    // Price
                    Text(
                      '₹${price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Row(
                children: [
                  // Service Icon - prefer imageUrl, if null or empty then show dummy image
                  if (iconUrl != null && iconUrl.toString().trim().isNotEmpty)
                    buildNetworkImage(
                      imageUrl: iconUrl.toString(),
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.contain,
                      errorWidget: Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
                    )
                  else
                    Icon(Icons.directions_car, size: 32.sp, color: Colors.grey[600]),
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
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                            ),
                            if (capacity != null) ...[
                              Gap(4.w),
                              Icon(Ionicons.person, size: 12.sp, color: isDark ? Colors.white70 : Colors.black87),
                              Gap(2.w),
                              Text(
                                capacity.toString(),
                                style: TextStyle(fontSize: 12.sp, color: isDark ? Colors.white70 : Colors.black87),
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
                      ],
                    ),
                  ),
                  // Price
                  Text(
                    '₹${price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildContinueButton(BuildContext context, IntercityServiceType? selectedService, bool isDark) {
    // final serviceName = 'CONTINUE';
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1469B5), const Color(0xFF942FAF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: const Color(0xFF1469B5).withOpacity(0.3), blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (selectedService == null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a vehicle')));
              return;
            }
            // Pass vehicleType to the next screen
            Navigator.pushNamed(
              context,
              '/share_pooling_search',
              arguments: {'vehicleType': selectedService.vehicleType ?? 'CAR_NORMAL'},
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              'Select Vehicle',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
  }
}
