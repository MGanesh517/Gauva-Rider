import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivateBookingPage extends ConsumerStatefulWidget {
  const PrivateBookingPage({super.key});

  @override
  ConsumerState<PrivateBookingPage> createState() => _PrivateBookingPageState();
}

class _PrivateBookingPageState extends ConsumerState<PrivateBookingPage> {
  int selectedCategoryIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {'name': 'Car', 'icon': Icons.directions_car, 'price': 2500, 'capacity': 4},
    {'name': 'SUV', 'icon': Icons.airport_shuttle, 'price': 3500, 'capacity': 6},
    {'name': 'Auto', 'icon': Icons.electric_rickshaw, 'price': 1200, 'capacity': 3},
  ];

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    final isDark = ref.read(themeModeProvider.notifier).isDarkMode();

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('Private Booking'),
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Vehicle Type',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Gap(12.h),
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => Gap(12.w),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategoryIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategoryIndex = index),
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : (isDark ? Colors.grey[900] : Colors.grey[100]),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(cat['icon'], color: isSelected ? Colors.white : Colors.grey, size: 32.sp),
                          Gap(8.h),
                          Text(
                            cat['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : (isDark ? Colors.white : Colors.black),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Gap(24.h),

            Text(
              'Trip Details',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Gap(12.h),
            // Note: Reusing similar simulated inputs as search page for brevity, or create a common widget in real app
            _buildSimulationInput(context, isDark, 'Pickup Location', Icons.my_location),
            Gap(12.h),
            _buildSimulationInput(context, isDark, 'Drop Location', Icons.location_on),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: _buildDateTimeSelector(
                    context,
                    isDark,
                    label: selectedDate == null ? 'Date' : '${selectedDate!.day}/${selectedDate!.month}',
                    icon: Icons.calendar_today,
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );
                      if (date != null) setState(() => selectedDate = date);
                    },
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: _buildDateTimeSelector(
                    context,
                    isDark,
                    label: selectedTime == null ? 'Time' : selectedTime!.format(context),
                    icon: Icons.access_time,
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (time != null) setState(() => selectedTime = time);
                    },
                  ),
                ),
              ],
            ),
            Gap(32.h),
            _buildSummaryCard(isDark),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? Colors.black : Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Processing Private Booking... Status: HOLD')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text(
              'BOOK NOW (HOLD)',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSimulationInput(BuildContext context, bool isDark, String hint, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }

  Widget _buildDateTimeSelector(
    BuildContext context,
    bool isDark, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[900] : Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 20.sp),
            Gap(8.w),
            Text(
              label,
              style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(bool isDark) {
    final cat = categories[selectedCategoryIndex];
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.grey[900]
            : Colors.yellow[50], // Yellow tint to highlight 'Hold' nature maybe? No, let's keep clean.
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${cat['name']} Full Booking',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹${cat['price']}',
                style: TextStyle(color: Colors.blue, fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Gap(8.h),
          Text('Capacity: ${cat['capacity']} Seats', style: TextStyle(color: Colors.grey)),
          Gap(16.h),
          Row(
            children: [
              Icon(Icons.info_outline, size: 16.sp, color: Colors.orange),
              Gap(8.w),
              Expanded(
                child: Text(
                  'Your booking will be on HOLD until confirmed by Admin.',
                  style: TextStyle(color: Colors.orange, fontSize: 12.sp, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
