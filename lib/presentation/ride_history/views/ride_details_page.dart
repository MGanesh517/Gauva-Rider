import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:gauva_userapp/core/extensions/extensions.dart';
import 'package:gauva_userapp/core/theme/color_palette.dart';
import 'package:gauva_userapp/core/utils/helpers.dart';
import 'package:gauva_userapp/core/utils/is_dark_mode.dart';
import 'package:gauva_userapp/core/widgets/buttons/app_back_button.dart';
import 'package:gauva_userapp/data/models/ride_history_response/ride_history_item.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/ride_history/widgets/ride_activity_card.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/change_status_bar.dart';
import '../../../core/utils/is_arabic.dart';
import '../../../generated/l10n.dart';

class RideDetailsPage extends ConsumerStatefulWidget {
  const RideDetailsPage({super.key, required this.ride});
  final RideHistoryItem ride;

  @override
  ConsumerState<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends ConsumerState<RideDetailsPage> {
  late bool isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  @override
  void dispose() {
    setStatusBar(isDark: isDark);
    super.dispose();
  }

  void _copyText(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    showNotification(message: AppLocalizations.of(context).textCopied, isSuccess: true);
  }

  @override
  Widget build(BuildContext context) {
    final bool isComplete = widget.ride.status != null && widget.ride.status!.toLowerCase().contains('completed');
    final bool isDark = isDarkMode();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppBackButton(color: isDark ? Colors.white : null),
        title: Text(
          AppLocalizations.of(context).rideDetails,
          style: context.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : const Color(0xFF24262D),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 8.r),
                padding: EdgeInsets.all(16.r),
                color: isDarkMode() ? AppColors.surface : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rideActivityCard(context, ride: widget.ride, showCancelItem: !isComplete, isDark: isDark),
                    Gap(16.h),

                    // Ride Details Section
                    _buildDetailsSection(context, widget.ride, isDark, isComplete),

                    Gap(16.h),

                    // Driver Information Section
                    if (widget.ride.driver != null) _buildDriverSection(context, widget.ride.driver!, isDark),

                    Gap(16.h),

                    // Vehicle Information Section
                    if (widget.ride.driver?.vehicle != null)
                      _buildVehicleSection(context, widget.ride.driver!.vehicle!, isDark),

                    Gap(16.h),

                    // Payment Details Section
                    _buildPaymentSection(context, widget.ride, isDark),

                    Gap(16.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Details Section
  Widget _buildDetailsSection(BuildContext context, RideHistoryItem ride, bool isDark, bool isComplete) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEEF1), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ride Details',
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
          Gap(12.h),
          Divider(color: const Color(0xFFEDEEF1), height: 1.h),
          Gap(12.h),

          // Status
          rowTextDetail(
            context,
            title: AppLocalizations.of(context).status,
            value: Expanded(
              child: Text(
                ride.status?.capitalize() ?? 'N/A',
                textAlign: TextAlign.end,
                style: context.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isComplete ? const Color(0xFF36B37E) : const Color(0xFFFF5630),
                ),
              ),
            ),
            isDark: isDark,
          ),
          Gap(12.h),

          // Pickup Location
          if (ride.pickupArea != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 16.sp, color: Colors.green),
                Gap(8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pickup Location',
                        style: context.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        ride.pickupArea!,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : const Color(0xFF24262D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),
          ],

          // Destination Location
          if (ride.destinationArea != null) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.location_on, size: 16.sp, color: Colors.red),
                Gap(8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Destination Location',
                        style: context.bodyMedium?.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        ride.destinationArea!,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : const Color(0xFF24262D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),
          ],

          // Ride ID
          if (ride.id != null)
            rowTextDetail(
              context,
              title: 'Ride ID',
              value: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '#${ride.id}',
                      textAlign: TextAlign.end,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                      ),
                    ),
                    Gap(8.w),
                    GestureDetector(
                      onTap: () => _copyText(context, ride.id.toString()),
                      child: Icon(Icons.copy, size: 16.sp, color: ColorPalette.primary50),
                    ),
                  ],
                ),
              ),
              isDark: isDark,
            ),
          if (ride.id != null) Gap(12.h),

          // Distance
          if (ride.distance != null)
            rowTextDetail(
              context,
              title: 'Distance',
              value: Expanded(
                child: Text(
                  '${ride.distance!.toStringAsFixed(2)} km',
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (ride.distance != null) Gap(12.h),

          // Duration
          if (ride.duration != null)
            rowTextDetail(
              context,
              title: 'Duration',
              value: Expanded(
                child: Text(
                  '${((ride.duration ?? 0) / 60).toStringAsFixed(2)} min',
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (ride.duration != null) Gap(12.h),

          // Start Time
          if (ride.startTime != null)
            rowTextDetail(
              context,
              title: 'Start Time',
              value: Expanded(
                child: Text(
                  _formatDateTime(ride.startTime),
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (ride.startTime != null) Gap(12.h),

          // End Time
          if (ride.endTime != null)
            rowTextDetail(
              context,
              title: 'End Time',
              value: Expanded(
                child: Text(
                  _formatDateTime(ride.endTime),
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
        ],
      ),
    );
  }

  // Build Driver Section
  Widget _buildDriverSection(BuildContext context, DriverInfo driver, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEEF1), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Driver Information',
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
          Gap(12.h),
          Divider(color: const Color(0xFFEDEEF1), height: 1.h),
          Gap(12.h),

          // Driver Name
          if (driver.name != null)
            rowTextDetail(
              context,
              title: 'Name',
              value: Expanded(
                child: Text(
                  driver.name!,
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (driver.name != null) Gap(12.h),

          // Driver Mobile
          if (driver.mobile != null)
            rowTextDetail(
              context,
              title: 'Mobile',
              value: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      driver.mobile!,
                      textAlign: TextAlign.end,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                      ),
                    ),
                    Gap(8.w),
                    GestureDetector(
                      onTap: () => _copyText(context, driver.mobile!),
                      child: Icon(Icons.copy, size: 16.sp, color: ColorPalette.primary50),
                    ),
                  ],
                ),
              ),
              isDark: isDark,
            ),
          if (driver.mobile != null) Gap(12.h),

          // Driver Rating
          if (driver.rating != null)
            rowTextDetail(
              context,
              title: 'Rating',
              value: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.star, size: 16.sp, color: Colors.amber),
                    Gap(4.w),
                    Text(
                      driver.rating!.toStringAsFixed(1),
                      textAlign: TextAlign.end,
                      style: context.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                      ),
                    ),
                  ],
                ),
              ),
              isDark: isDark,
            ),
        ],
      ),
    );
  }

  // Build Vehicle Section
  Widget _buildVehicleSection(BuildContext context, VehicleInfo vehicle, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEEF1), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Information',
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
          Gap(12.h),
          Divider(color: const Color(0xFFEDEEF1), height: 1.h),
          Gap(12.h),

          // License Plate
          if (vehicle.licensePlate != null)
            rowTextDetail(
              context,
              title: 'License Plate',
              value: Expanded(
                child: Text(
                  vehicle.licensePlate!,
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (vehicle.licensePlate != null) Gap(12.h),

          // Model
          if (vehicle.model != null)
            rowTextDetail(
              context,
              title: 'Model',
              value: Expanded(
                child: Text(
                  vehicle.model!,
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (vehicle.model != null) Gap(12.h),

          // Color
          if (vehicle.color != null)
            rowTextDetail(
              context,
              title: 'Color',
              value: Expanded(
                child: Text(
                  vehicle.color!,
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
          if (vehicle.color != null) Gap(12.h),

          // Year
          if (vehicle.year != null)
            rowTextDetail(
              context,
              title: 'Year',
              value: Expanded(
                child: Text(
                  vehicle.year!,
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
                  ),
                ),
              ),
              isDark: isDark,
            ),
        ],
      ),
    );
  }

  // Build Payment Section
  Widget _buildPaymentSection(BuildContext context, RideHistoryItem ride, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surface : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFEDEEF1), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: context.bodyMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
          Gap(12.h),
          Divider(color: const Color(0xFFEDEEF1), height: 1.h),
          Gap(12.h),

          // Fare/Price
          if (ride.fare != null)
            rowTextDetail(
              context,
              title: 'Total Fare',
              value: Expanded(
                child: Text(
                  '₹${ride.fare!.toStringAsFixed(2)}',
                  textAlign: TextAlign.end,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorPalette.primary50,
                  ),
                ),
              ),
              isDark: isDark,
            ),
        ],
      ),
    );
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return 'N/A';
    try {
      final date = DateTime.parse(dateTime);
      return DateFormat('MMM dd, yyyy • HH:mm').format(date);
    } catch (e) {
      return dateTime;
    }
  }
}

Widget rowTextDetail(BuildContext context, {required String title, Widget? value, required bool isDark}) => Row(
  children: [
    Expanded(
      child: Text(
        title,
        textAlign: isArabic() ? TextAlign.right : TextAlign.left,
        style: context.bodyMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: isDark ? const Color(0xFF687387) : const Color(0xFF2E2E2E),
        ),
      ),
    ),
    if (value != null) value,
  ],
);

Widget issueButton(
  BuildContext context, {
  String title = '',
  IconData? icon,
  Color? backgroundColor,
  Color? textColor,
  Function()? onTap,
  bool isLoading = false,
}) => InkWell(
  onTap: isLoading ? null : onTap,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
    decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(4.r)),
    child: isLoading
        ? SizedBox(
            height: 25.h,
            width: 25.w,
            child: Center(
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
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 18.h),
              Gap(6.w),
              Flexible(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: context.bodyMedium?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w400, color: textColor),
                ),
              ),
            ],
          ),
  ),
);
