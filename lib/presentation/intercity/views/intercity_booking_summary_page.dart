import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/presentation/account_page/provider/theme_provider.dart';
import 'package:gauva_userapp/presentation/intercity/provider/intercity_service_providers.dart';
import 'package:gauva_userapp/data/models/intercity_trip_model.dart';
import 'package:gauva_userapp/data/models/intercity_search_response.dart';

import 'package:gauva_userapp/presentation/profile/provider/rider_details_provider.dart';

class IntercityBookingSummaryPage extends ConsumerStatefulWidget {
  final IntercityTripModel? trip;
  final VehicleOption? vehicleOption;
  final int seatsToBook;
  final String pickupAddress;
  final String dropAddress;
  final LatLng pickupLocation;
  final LatLng dropLocation;

  // New fields
  final int? routeId;
  final bool isPrivateBooking;

  const IntercityBookingSummaryPage({
    super.key,
    this.trip,
    this.vehicleOption,
    required this.seatsToBook,
    required this.pickupAddress,
    required this.dropAddress,
    required this.pickupLocation,
    required this.dropLocation,
    this.routeId,
    this.isPrivateBooking = false,
  }) : assert(trip != null || vehicleOption != null, 'Either trip or vehicleOption must be provided');

  @override
  ConsumerState<IntercityBookingSummaryPage> createState() => _IntercityBookingSummaryPageState();
}

class _IntercityBookingSummaryPageState extends ConsumerState<IntercityBookingSummaryPage> {
  bool isLoading = false;

  // Form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  String _paymentMethod = 'ONLINE'; // Default to ONLINE as per HTML tool recommendation for online flow

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(riderDetailsNotifierProvider)
          .maybeWhen(
            success: (response) {
              final user = response.data?.user;
              if (user != null) {
                if (user.mobile != null && _phoneController.text.isEmpty) {
                  setState(() => _phoneController.text = user.mobile!);
                }
                if (user.name != null && _nameController.text.isEmpty) {
                  setState(() => _nameController.text = user.name!);
                }
                if (user.email != null && _emailController.text.isEmpty) {
                  setState(() => _emailController.text = user.email!);
                }
              }
            },
            orElse: () {},
          );
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _confirmBooking() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your full name')));
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email')));
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a contact phone number')));
      return;
    }

    setState(() => isLoading = true);
    final notifier = ref.read(intercityServiceNotifierProvider.notifier);

    // Determine details
    final String vehicleType = widget.trip?.vehicleType ?? widget.vehicleOption?.vehicleType ?? 'CAR_NORMAL';
    final int? tripId = widget.trip?.tripId;

    // Prefer passed routeId, otherwise try to get from vehicleOption if available
    final int? routeId = widget.routeId ?? widget.vehicleOption?.routeId;

    await notifier.createIntercityBooking(
      vehicleType: vehicleType,
      bookingType: widget.isPrivateBooking ? 'PRIVATE' : 'SHARE_POOL',
      seatsToBook: widget.seatsToBook,
      tripId: tripId,
      routeId: routeId,
      pickupAddress: widget.pickupAddress,
      pickupLatitude: widget.pickupLocation.latitude,
      pickupLongitude: widget.pickupLocation.longitude,
      dropAddress: widget.dropAddress,
      dropLatitude: widget.dropLocation.latitude,
      dropLongitude: widget.dropLocation.longitude,
      paymentMethod: _paymentMethod,
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      contactPhone: _phoneController.text.trim(),
      specialInstructions: _instructionsController.text.trim().isNotEmpty ? _instructionsController.text.trim() : null,
    );

    if (mounted) {
      setState(() => isLoading = false);

      // Check for success in state (or handle via listener usually, but here checking simple success flow)
      // The notifier shows a notification on success/failure.
      // If success, we should probably navigate away.
      // Ideally we listen to the state change, but for simplicity:
      final state = ref.read(intercityServiceNotifierProvider);
      state.bookingState.maybeWhen(
        success: (_) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        orElse: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeModeProvider.notifier).isDarkMode();

    // Calculate costs
    double pricePerSeat = widget.trip?.currentPerHeadPrice ?? widget.vehicleOption?.currentPerHeadPrice ?? 0.0;
    if (widget.isPrivateBooking) {
      double? vehicleTotal = widget.trip?.totalPrice ?? widget.vehicleOption?.totalPrice;
      if (vehicleTotal != null) {
        pricePerSeat = vehicleTotal;
      }
    }

    double totalCost = widget.isPrivateBooking ? pricePerSeat : (pricePerSeat * widget.seatsToBook);

    final String title = widget.trip != null
        ? (widget.isPrivateBooking ? 'Private Trip' : 'Join Trip')
        : (widget.isPrivateBooking ? 'Book Private Vehicle' : 'Book Seat(s)');
    final String subTitle = widget.trip?.driverName ?? widget.vehicleOption?.displayName ?? 'Service';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9FAFB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Booking Summary',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),
        backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip/Vehicle Details Card
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: widget.isPrivateBooking
                                      ? const Color(0xFF9C27B0).withOpacity(0.1)
                                      : const Color(0xFF1469B5).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  widget.isPrivateBooking ? 'PRIVATE' : 'SHARE POOL',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isPrivateBooking ? const Color(0xFF9C27B0) : const Color(0xFF1469B5),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(8.h),
                          Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF2D3436),
                            ),
                          ),
                          if (widget.trip?.vehicleDisplayName != null) ...[
                            Gap(4.h),
                            Text(
                              widget.trip!.vehicleDisplayName!,
                              style: TextStyle(fontSize: 14.sp, color: isDark ? Colors.grey[400] : Colors.grey[700]),
                            ),
                          ],
                          if (widget.trip != null) ...[
                            Gap(12.h),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, size: 18.sp, color: const Color(0xFFFFB300)),
                                Gap(4.w),
                                Text(
                                  '${widget.trip?.driverRating?.toStringAsFixed(1) ?? "N/A"} • ${widget.trip?.vehicleNumber ?? ""}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey[100]),
                    Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          _buildLocationRow(Icons.radio_button_checked, widget.pickupAddress, isDark, isSource: true),
                          Gap(24.h),
                          _buildLocationRow(Icons.location_on_rounded, widget.dropAddress, isDark, isSource: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Gap(32.h),

              // Contact & Instructions
              Text(
                'Contact Details',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF2D3436),
                ),
              ),
              Gap(16.h),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline_rounded,
                isDark: isDark,
              ),
              Gap(16.h),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                inputType: TextInputType.emailAddress,
                isDark: isDark,
              ),
              Gap(16.h),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                inputType: TextInputType.phone,
                isDark: isDark,
              ),
              Gap(16.h),
              _buildTextField(
                controller: _instructionsController,
                label: 'Special Instructions (Optional)',
                icon: Icons.note_alt_outlined,
                maxLines: 2,
                isDark: isDark,
              ),

              Gap(32.h),

              // Payment Summary
              Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF2D3436),
                ),
              ),
              Gap(16.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 16, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    if (!widget.isPrivateBooking) ...[
                      _buildPriceRow('Price per seat', '₹${pricePerSeat.toStringAsFixed(0)}', isDark),
                      Gap(12.h),
                      _buildPriceRow('Seats', 'x ${widget.seatsToBook}', isDark),
                      Gap(16.h),
                      Divider(color: isDark ? Colors.white10 : Colors.grey[100]),
                      Gap(16.h),
                    ],
                    _buildPriceRow(
                      'Total Payable',
                      '₹${totalCost.toStringAsFixed(0)}',
                      isDark,
                      isBold: true,
                      color: const Color(0xFF1469B5),
                      valueFontSize: 20.sp,
                    ),
                  ],
                ),
              ),

              Gap(32.h),

              // Payment Method
              Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF2D3436),
                ),
              ),
              Gap(16.h),
              _buildPaymentOption('ONLINE', 'Pay Online (Razorpay)', Icons.credit_card_rounded, isDark),
              Gap(12.h),
              _buildPaymentOption('CASH', 'Pay Cash to Driver', Icons.money_rounded, isDark),

              Gap(40.h),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1469B5),
                    elevation: 0,
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 24.h,
                          height: 24.h,
                          child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : Text(
                          'CONFIRM BOOKING',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            // letterSpacing: 0.5,
                          ),
                        ),
                ),
              ),
              // Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDark,
    TextInputType inputType = TextInputType.text,
    int maxLines = 1,
  }) => Container(
    decoration: BoxDecoration(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2))],
    ),
    child: TextField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      style: TextStyle(
        color: isDark ? Colors.white : const Color(0xFF2D3436),
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
        prefixIcon: Icon(icon, color: const Color(0xFF1469B5), size: 22.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    ),
  );

  Widget _buildPaymentOption(String value, String label, IconData icon, bool isDark) {
    final isSelected = _paymentMethod == value;
    final activeColor = const Color(0xFF1469B5);

    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.08) : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? activeColor : (isDark ? Colors.white10 : Colors.transparent),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? []
              : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isSelected ? activeColor.withOpacity(0.1) : (isDark ? Colors.grey[800] : Colors.grey[50]),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: isSelected ? activeColor : Colors.grey[600], size: 24.sp),
            ),
            Gap(16.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF2D3436),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: activeColor, size: 24.sp)
            else
              Container(
                width: 24.sp,
                height: 24.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[400]!, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String text, bool isDark, {required bool isSource}) {
    final iconColor = isSource ? const Color(0xFF27AE60) : const Color(0xFFC0392B);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Icon(Icons.radio_button_checked, size: 18.sp, color: iconColor),
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isSource ? "Pick-up Location" : "Drop-off Location",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              Gap(4.h),
              Text(
                text,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: isDark ? Colors.white.withOpacity(0.9) : const Color(0xFF2D3436),
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String value,
    bool isDark, {
    bool isBold = false,
    Color? color,
    double? valueFontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize ?? 15.sp,
            color: color ?? (isDark ? Colors.white : const Color(0xFF2D3436)),
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
