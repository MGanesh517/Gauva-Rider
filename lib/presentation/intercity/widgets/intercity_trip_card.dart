import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/data/models/intercity_trip_model.dart';

import 'package:intl/intl.dart';

class IntercityTripCard extends StatelessWidget {
  final IntercityTripModel trip;
  final bool isDark;
  final Function(IntercityTripModel trip) onJoinPressed;
  final bool showJoinButton;

  const IntercityTripCard({
    super.key,
    required this.trip,
    required this.isDark,
    required this.onJoinPressed,
    this.showJoinButton = true,
  });

  String _formatTime(String? dateStr) {
    if (dateStr == null) return '--:--';
    try {
      final date = DateTime.parse(dateStr).toLocal();
      return DateFormat('HH:mm').format(date);
    } catch (e) {
      return '--:--';
    }
  }

  String _calculateEndTime(String? startDateStr, int? durationMinutes) {
    if (startDateStr == null) return '--:--';
    try {
      final startDate = DateTime.parse(startDateStr).toLocal();
      final endDate = startDate.add(Duration(minutes: durationMinutes ?? 0));
      return DateFormat('HH:mm').format(endDate);
    } catch (e) {
      return '--:--';
    }
  }

  String _formatDuration(int? minutes) {
    if (minutes == null) return '';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (m == 0) return '${h}h';
    return '${h}h${m.toString().padLeft(2, '0')}';
  }

  String _getCityName(String? address) {
    if (address == null || address.isEmpty) return 'Unknown';
    // Simple heuristic: take the first part of the address split by comma
    return address.split(',').first.trim();
  }

  @override
  Widget build(BuildContext context) {
    final startTime = _formatTime(trip.scheduledDeparture);
    final endTime = _calculateEndTime(trip.scheduledDeparture, trip.estimatedDurationMinutes);
    final duration = _formatDuration(trip.estimatedDurationMinutes);
    final pickupCity = _getCityName(trip.pickupAddress);
    final dropCity = _getCityName(trip.dropAddress);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () => onJoinPressed(trip),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              // Top Section: Timeline & Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Times & Duration
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        startTime,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        duration,
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      Gap(4.h),
                      Text(
                        endTime,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Gap(12.w),
                  // Graphics (Dots & Line)
                  Column(
                    children: [
                      Gap(6.h),
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? Colors.white70 : Colors.black54, width: 2),
                          color: Colors.transparent,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 34.h, // Adjusted height for spacing
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                      ),
                      Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: isDark ? Colors.white70 : Colors.black54, width: 2),
                          color: Colors.transparent, // Filled for destination
                        ),
                      ),
                    ],
                  ),
                  Gap(12.w),
                  // Locations
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pickupCity,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(28.h), // Spacing to align with times
                        Text(
                          dropCity,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  // Price
                  Text(
                    '₹${trip.currentPerHeadPrice?.toStringAsFixed(0) ?? 0}',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1469B5),
                    ),
                  ),
                ],
              ),

              Gap(16.h),
              Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[200]),
              Gap(12.h),

              // Bottom Section: Driver Info, Seats, & Action
              Row(
                children: [
                  // Vehicle Icon
                  Icon(Icons.directions_car, size: 20.sp, color: Colors.grey[500]),
                  Gap(8.w),
                  // Driver Avatar
                  CircleAvatar(
                    radius: 14.r,
                    backgroundColor: Colors.blue.shade50,
                    child: Text(
                      trip.driverName?.isNotEmpty == true ? trip.driverName![0].toUpperCase() : 'D',
                      style: TextStyle(color: const Color(0xFF1469B5), fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                  ),
                  Gap(8.w),
                  // Name & Rating
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.driverName ?? 'Verified Driver',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 12.sp, color: const Color(0xFFFFC107)),
                          Gap(2.w),
                          Text(
                            trip.driverRating?.toStringAsFixed(1) ?? '4.8',
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  // Join Button / Lightning
                  if (showJoinButton)
                    ElevatedButton.icon(
                      onPressed: () => onJoinPressed(trip),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
                        foregroundColor: isDark ? Colors.white : Colors.black,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      icon: Icon(Icons.flash_on_rounded, size: 16.sp, color: Colors.amber[700]), // Lighting icon
                      label: Text(
                        "Join",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                    ),
                ],
              ),
              // Seat Availability (Optional, small text below if needed, or Integrated)
              if ((trip.availableSeats ?? 0) <= 2)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Only ${trip.availableSeats} seats left',
                        style: TextStyle(fontSize: 10.sp, color: Colors.red, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
