import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';

class SeatSelectionSheet extends ConsumerStatefulWidget {
  final int maxSeats;
  final int minSeats;
  final int availableSeats;
  final Function(int selectedSeats) onConfirm;

  const SeatSelectionSheet({
    super.key,
    required this.maxSeats,
    required this.minSeats,
    required this.availableSeats,
    required this.onConfirm,
  });

  @override
  ConsumerState<SeatSelectionSheet> createState() => _SeatSelectionSheetState();
}

class _SeatSelectionSheetState extends ConsumerState<SeatSelectionSheet> {
  int selectedSeats = 1;

  @override
  void initState() {
    super.initState();
    selectedSeats = widget.minSeats;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();
    final maxSelectable = widget.availableSeats < widget.maxSeats ? widget.availableSeats : widget.maxSeats;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Text(
              'Select Number of Seats',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Gap(8.h),
            Text(
              'Available: ${widget.availableSeats} seats',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
            Gap(24.h),
            // Seat selector
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrease button
                IconButton(
                  onPressed: selectedSeats > widget.minSeats ? () => setState(() => selectedSeats--) : null,
                  icon: Icon(Icons.remove_circle_outline, size: 32.sp),
                  color: selectedSeats > widget.minSeats ? (isDark ? Colors.white : Colors.black) : Colors.grey,
                ),
                Gap(24.w),
                // Seat count display
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1469B5), width: 2),
                  ),
                  child: Text(
                    '$selectedSeats',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                Gap(24.w),
                // Increase button
                IconButton(
                  onPressed: selectedSeats < maxSelectable ? () => setState(() => selectedSeats++) : null,
                  icon: Icon(Icons.add_circle_outline, size: 32.sp),
                  color: selectedSeats < maxSelectable ? (isDark ? Colors.white : Colors.black) : Colors.grey,
                ),
              ],
            ),
            Gap(8.h),
            // Seat range info
            Center(
              child: Text(
                'Min: ${widget.minSeats} | Max: $maxSelectable',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ),
            Gap(32.h),
            // Confirm button
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1469B5), Color(0xFF942FAF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF1469B5).withOpacity(0.3), blurRadius: 4, offset: Offset(0, 2)),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onConfirm(selectedSeats);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Center(
                    child: Text(
                      'Confirm Booking',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
