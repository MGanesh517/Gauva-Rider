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
import '../../../core/theme/color_palette.dart';
import '../../../core/utils/is_dark_mode.dart';
import '../provider/providers.dart';
import '../widgets/ride_activity_card.dart';

class RideHistoryPage extends ConsumerStatefulWidget {
  const RideHistoryPage({super.key});

  @override
  ConsumerState<RideHistoryPage> createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends ConsumerState<RideHistoryPage> {
  bool isCompleteSelected = true;
  DateTime? date;
  @override
  void initState() {
    super.initState();
    isCompleteSelected = true;
    date = null;
    // Optionally fetch ride history when page loads
    Future.microtask(() => ref.read(rideHistoryProvider.notifier).fetchRideHistory(status: 'Completed'));
  }

  void _fetchData() {
    ref
        .read(rideHistoryProvider.notifier)
        .fetchRideHistory(
          status: isCompleteSelected ? 'Completed' : 'Cancelled',
          date: date == null ? null : DateFormat('yyyy-MM-dd', 'en').format(date!),
        );
  }

  @override
  Widget build(BuildContext context) {
    final rideState = ref.watch(rideHistoryProvider);
    final isDark = isDarkMode();

    return RefreshIndicator(
      onRefresh: () async {
        _fetchData();
        // ref
        //     .read(rideHistoryProvider.notifier)
        //     .fetchRideHistory(
        //       status: isCompleteSelected ? 'Completed' : 'Canceled',
        //     );
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: isDark ? Colors.black : Colors.white,
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text(
        //     AppLocalizations.of(context).activity,
        //     style: context.bodyMedium?.copyWith(
        //       fontSize: 16.sp,
        //       fontWeight: FontWeight.w500,
        //       color: isDarkMode() ? Colors.white : const Color(0xFF24262D),
        //     ),
        //   ),
        //   automaticallyImplyLeading: false,
        //   actions: [
        //     InkWell(
        //       onTap: () async {
        //         date = await customDatePickerReturnDate(
        //           context,
        //           initialDate: date,
        //           lastDate: DateTime.now(),
        //           firstDate: DateTime.now().subtract(const Duration(days: 1000)),
        //         );
        //         setState(() {});
        //         await Future.delayed(const Duration(milliseconds: 100));
        //         _fetchData();
        //       },
        //       child: Row(
        //         children: [
        //           Text(
        //             date == null ? '' : DateFormat('dd-MM-yyyy', 'en').format(date!),
        //             // AppLocalizations.of(context).today,
        //             style: context.bodyMedium?.copyWith(
        //               fontSize: 14.sp,
        //               fontWeight: FontWeight.w400,
        //               color: const Color(0xFF687387),
        //             ),
        //           ),
        //           Gap(8.w),
        //           Icon(Icons.calendar_month, color: ColorPalette.primary50, size: 24.h),
        //           Gap(16.w),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,

          title: Text(
            AppLocalizations.of(context).activity,
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: isDarkMode() ? Colors.white : Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,

          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDarkMode() ? [Colors.black, Colors.black87] : const [Color(0xFF397098), Color(0xFF942FAF)],
              ),
            ),
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
        body: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: isDarkMode() ? Colors.black : Colors.white,
              ),
              child: Row(
                children: [
                  button(
                    isSelected: isCompleteSelected,
                    isDark: isDarkMode(),
                    label: AppLocalizations.of(context).complete_ride,
                    onTap: () {
                      if (!isCompleteSelected) {
                        setState(() {
                          isCompleteSelected = true;
                        });
                        _fetchData();
                      }
                    },
                    context: context,
                  ),
                  button(
                    isSelected: !isCompleteSelected,
                    isDark: isDarkMode(),
                    label: AppLocalizations.of(context).cancel_ride,
                    onTap: () {
                      if (isCompleteSelected) {
                        setState(() {
                          isCompleteSelected = false;
                        });
                        _fetchData();
                      }
                    },
                    context: context,
                  ),
                ],
              ),
            ),
            Expanded(
              child: rideState.when(
                initial: () => Center(child: Text(AppLocalizations.of(context).please_wait)),
                loading: () => const LoadingView(),
                error: (e) => Center(child: Text(AppLocalizations.of(context).error_with_msg(e.message.toString()))),
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
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return rideHistoryCard(
                        context,
                        order: order,
                        onTap: () {
                          NavigationService.pushNamed(AppRoutes.rideHistoryDetail, arguments: order);
                        },
                        showCancelItem: !isCompleteSelected,
                        isDark: isDarkMode(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    required bool isSelected,
    required String label,
    required VoidCallback onTap,
    required BuildContext context,
    required bool isDark,
  }) => Expanded(
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: isSelected ? const Color(0xFF1469B5) : Colors.transparent),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? const Color(0xFF1469B5)
                : isDark
                ? Colors.white
                : const Color(0xFF24262D),
          ),
        ),
      ),
    ),
  );
}
