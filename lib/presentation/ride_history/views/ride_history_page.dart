import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/routes/app_routes.dart';
import 'package:gauva_userapp/core/utils/date_picker.dart';
import 'package:gauva_userapp/data/services/navigation_service.dart';
import 'package:gauva_userapp/generated/l10n.dart';

import '../../../common/loading_view.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../provider/providers.dart';
import '../widgets/ride_activity_card.dart';
import '../widgets/intercity_ride_history_card.dart';

class RideHistoryPage extends ConsumerStatefulWidget {
  const RideHistoryPage({super.key});

  @override
  ConsumerState<RideHistoryPage> createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends ConsumerState<RideHistoryPage> {
  DateTime? date;

  @override
  void initState() {
    super.initState();
    date = null;
    // Optionally fetch ride history when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(rideHistoryProvider.notifier).fetchRideHistory(status: 'Completed');
      ref.read(intercityRideHistoryProvider.notifier).fetchIntercityRideHistory();
    });
  }

  void _fetchData() {
    ref
        .read(rideHistoryProvider.notifier)
        .fetchRideHistory(status: 'Completed', date: date == null ? null : DateFormat('yyyy-MM-dd', 'en').format(date!));
    ref.read(intercityRideHistoryProvider.notifier).fetchIntercityRideHistory();
  }

  @override
  Widget build(BuildContext context) {
    final rideState = ref.watch(rideHistoryProvider);
    final intercityState = ref.watch(intercityRideHistoryProvider);
    final isDark = isDarkMode();

    return DefaultTabController(
      length: 2,
      child: RefreshIndicator(
        onRefresh: () async {
          _fetchData();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,

            title: Text(
              AppLocalizations.of(context).activity,
              style: context.bodyMedium?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            automaticallyImplyLeading: false,

            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark ? [Colors.black, Colors.black87] : const [Color(0xFF397098), Color(0xFF942FAF)],
                ),
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: context.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "Ride History"),
                Tab(text: "Intercity History"),
              ],
            ),

            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),

            actions: [
              InkWell(
                onTap: () async {
                  date = await customDatePickerReturnDate(
                    context,
                    initialDate: date,
                    lastDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 1000)),
                  );
                  setState(() {});
                  await Future.delayed(const Duration(milliseconds: 100));
                  _fetchData();
                },
                child: Row(
                  children: [
                    Text(
                      date == null ? '' : DateFormat('dd-MM-yyyy', 'en').format(date!),
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF687387),
                      ),
                    ),
                    Gap(8.w),
                    Icon(Icons.calendar_month, color: Colors.white, size: 24.h),
                    Gap(16.w),
                  ],
                ),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              // Tab 1: Regular Ride History
              Column(
                children: [
                  Gap(10.h),
                  Expanded(
                    child: rideState.when(
                      initial: () => Center(child: Text(AppLocalizations.of(context).please_wait)),
                      loading: () => const LoadingView(),
                      error: (e) =>
                          Center(child: Text(AppLocalizations.of(context).error_with_msg(e.message.toString()))),
                      success: (orders) {
                        if (orders.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).no_rides_yet,
                              style: context.bodyLarge?.copyWith(color: Colors.red),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: orders.length,
                          // PERFORMANCE OPTIMIZATION: Add cacheExtent for better scroll performance
                          cacheExtent: 500, // Cache 500 pixels worth of items off-screen
                          // PERFORMANCE OPTIMIZATION: Add addAutomaticKeepAlives for better item preservation
                          addAutomaticKeepAlives: false, // Don't keep items alive when scrolled away
                          addRepaintBoundaries: true, // Add repaint boundaries for each item
                          itemBuilder: (context, index) {
                            final ride = orders[index];
                            return rideHistoryCard(
                              context,
                              ride: ride,
                              onTap: () {
                                NavigationService.pushNamed(AppRoutes.rideHistoryDetail, arguments: ride);
                              },
                              showCancelItem: false,
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              // Tab 2: Intercity History (New)
              Column(
                children: [
                  Gap(10.h),
                  Expanded(
                    child: intercityState.when(
                      initial: () => Center(child: Text(AppLocalizations.of(context).please_wait)),
                      loading: () => const LoadingView(),
                      error: (e) =>
                          Center(child: Text(AppLocalizations.of(context).error_with_msg(e.message.toString()))),
                      success: (orders) {
                        if (orders.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context).no_rides_yet, // Or specific message
                              style: context.bodyLarge?.copyWith(color: Colors.red),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: orders.length,
                          // PERFORMANCE OPTIMIZATION: Add cacheExtent for better scroll performance
                          cacheExtent: 500,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: true,
                          itemBuilder: (context, index) {
                            final ride = orders[index];
                            return intercityRideHistoryCard(
                              context,
                              ride: ride,
                              onTap: () {
                                // Add navigation if details page exists in future
                              },
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
