import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/core/utils/change_status_bar.dart';
import 'package:gauva_userapp/core/utils/exit_app_dialogue.dart';
import 'package:gauva_userapp/core/widgets/is_ios.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/utils/color_palette.dart';
import '../../../core/widgets/buttons/app_back_button.dart';
import '../../../data/models/waypoint.dart';
import '../../account_page/provider/theme_provider.dart';
import '../../waypoint/provider/search_place_providers.dart';
import '../../waypoint/provider/selected_loc_text_field_providers.dart';
import '../../waypoint/provider/way_point_list_providers.dart';
import '../../waypoint/widgets/place_lookup_state_view.dart';

class IntercityWaypointsInputSheet extends ConsumerStatefulWidget {
  final String? vehicleType;
  final String? bookingType;
  final Function({
    required String fromAddress,
    required String toAddress,
    required LatLng fromLocation,
    required LatLng toLocation,
    required DateTime selectedDate,
    required int seats,
  })
  onConfirm;

  const IntercityWaypointsInputSheet({super.key, this.vehicleType, this.bookingType, required this.onConfirm});

  @override
  ConsumerState<IntercityWaypointsInputSheet> createState() => _IntercityWaypointsInputSheetState();
}

class _IntercityWaypointsInputSheetState extends ConsumerState<IntercityWaypointsInputSheet> {
  Timer? _debounce;
  late bool isDark;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int seats = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isDark = ref.read(themeModeProvider.notifier).isDarkMode();
  }

  void _initializeWaypoints() {
    try {
      final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);
      wayPointNotifier.resetWayPoint();
      final _ = ref.refresh(selectedLocTextFieldNotifierProvider.notifier);

      // Initialize with empty waypoints for intercity
      wayPointNotifier.updateWayPoint(index: 0, name: 'Pick-up', address: '', location: const LatLng(0.0, 0.0));
      wayPointNotifier.updateWayPoint(index: 1, name: 'Destination', address: '', location: const LatLng(0.0, 0.0));
    } catch (e) {
      debugPrint('Error initializing waypoints: $e');
    }
  }

  void _onSearchChanged(String? value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () {
      if (value == null || value.trim().isEmpty) {
        ref.read(searchPlaceNotifierProvider.notifier).reset();
      } else if (value.length > 3) {
        ref.read(searchPlaceNotifierProvider.notifier).searchPlace(value);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    setStatusBar(isHome: true, isDark: isDark);
    super.dispose();
  }

  Waypoint _getWaypointByName(List<Waypoint> list, String name) => list.firstWhere(
    (element) => element.name == name,
    orElse: () => Waypoint(name: '', address: '', location: const LatLng(0, 0)),
  );

  @override
  Widget build(BuildContext context) {
    final wayPointList = ref.watch(wayPointListNotifierProvider);
    final pickupPoint = _getWaypointByName(wayPointList, 'Pick-up');
    final dropOffPoint = _getWaypointByName(wayPointList, 'Destination');

    return ExitAppWrapper(
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 110.h,
          leading: AppBackButton(color: isDark ? Colors.white : null),
          centerTitle: true,
          title: Text(
            widget.bookingType == 'SHARE_POOL'
                ? 'Share Pooling'
                : widget.bookingType == 'PRIVATE'
                ? 'Private Booking'
                : 'Search',
            style: context.titleMedium?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF24262D),
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
            color: isDark ? Colors.black : Colors.white,
          ),
          child: Column(
            children: [
              Container(height: 10.h, width: double.infinity, color: isDark ? Colors.black : ColorPalette.neutralF6),
              Expanded(
                child: SafeArea(
                  bottom: !isIos(),
                  child: Padding(
                    padding: const EdgeInsets.all(16).copyWith(bottom: isIos() ? 24.h : 16.h),
                    child: Column(
                      children: [
                        _buildWaypointList(wayPointList, isDark: isDark),
                        Gap(16.h),
                        // Date and Time Selection
                        _buildDateTimeSelector(isDark),
                        Gap(16.h),
                        const Expanded(child: PlaceLookupStateView()),
                        _buildConfirmButton(pickupPoint, dropOffPoint),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWaypoints();
      setStatusBar(isDark: isDark);
    });
  }

  Widget _buildDateTimeSelector(bool isDark) => Column(
    children: [
      // Date Selector
      GestureDetector(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
          );
          if (date != null) setState(() => selectedDate = date);
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.blue, size: 20.sp),
              Gap(8.w),
              Expanded(
                child: Text(
                  selectedDate == null ? 'Date' : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
      // Show seat selector only for share pooling
      if (widget.bookingType == 'SHARE_POOL') ...[
        Gap(12.h),
        // Seat Selector
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Seats',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                    onPressed: seats > 1 ? () => setState(() => seats--) : null,
                    icon: Icon(
                      Icons.remove_circle_outline,
                      size: 20.sp,
                      color: seats > 1 ? (isDark ? Colors.white : Colors.black) : Colors.grey,
                    ),
                  ),
                  Text(
                    '$seats',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 32.w, minHeight: 32.h),
                    onPressed: seats < 6 ? () => setState(() => seats++) : null,
                    icon: Icon(
                      Icons.add_circle_outline,
                      size: 20.sp,
                      color: seats < 6 ? (isDark ? Colors.white : Colors.black) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ],
  );

  Widget _buildWaypointList(List<Waypoint> wayPointList, {required bool isDark}) {
    final selectedField = ref.watch(selectedLocTextFieldNotifierProvider);
    final fieldNotifier = ref.read(selectedLocTextFieldNotifierProvider.notifier);
    final wayPointNotifier = ref.read(wayPointListNotifierProvider.notifier);

    // Only show first 2 waypoints (pickup and destination)
    final displayList = wayPointList.take(2).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? Colors.grey.shade800 : const Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon column with dots and line
          Column(
            children: displayList
                .mapIndexed(
                  (index, _) => Column(
                    children: [
                      Container(
                        width: 16.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: index == 0
                                ? const Color(0xFF34A853) // Green for pickup
                                : const Color(0xFFEA4335), // Red for destination
                            width: 2.5,
                          ),
                        ),
                      ),
                      if (index != displayList.length - 1)
                        Container(
                          width: 1,
                          height: 40.h,
                          margin: EdgeInsets.symmetric(vertical: 2.h),
                          color: isDark ? Colors.grey.shade700 : const Color(0xFFBDBDBD),
                        ),
                    ],
                  ),
                )
                .toList(),
          ),
          Gap(12.w),
          // Text fields column
          Expanded(
            child: Column(
              children: displayList
                  .mapIndexed(
                    (index, e) => Container(
                      key: ValueKey('waypoint_${index}_${e.address}'),
                      height: index == 0 ? 60.h : null, // Add height to first field for spacing
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        key: ValueKey('textfield_${index}_${e.address}'),
                        initialValue: e.address,
                        onChanged: (value) {
                          if (selectedField != index) {
                            fieldNotifier.setSelectedLocation(index);
                          }
                          _onSearchChanged(value);
                        },
                        onTap: () => fieldNotifier.setSelectedLocation(index),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: isDark ? Colors.white : const Color(0xFF212121),
                        ),
                        decoration: InputDecoration(
                          hintText: index == 0 ? 'Pick-up Location' : 'Destination',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: isDark ? Colors.grey.shade600 : const Color(0xFF757575),
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          suffixIcon: e.address.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 20.sp,
                                    color: isDark ? Colors.grey.shade600 : const Color(0xFF9E9E9E),
                                  ),
                                  onPressed: () {
                                    wayPointNotifier.removeWayPointByIndex(index: index);
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(Waypoint pickup, Waypoint dropOff) {
    // Only check date, not time
    final isEnabled = pickup.address.isNotEmpty && dropOff.address.isNotEmpty && selectedDate != null;

    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: isEnabled
            ? LinearGradient(
                colors: [const Color(0xFF1469B5), const Color(0xFF942FAF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: isEnabled ? null : Colors.grey,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isEnabled
            ? [BoxShadow(color: const Color(0xFF1469B5).withOpacity(0.3), blurRadius: 4, offset: Offset(0, 2))]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled
              ? () {
                  if (pickup.address.isEmpty || dropOff.address.isEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Please select pickup and destination locations')));
                    return;
                  }
                  if (selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select date')));
                    return;
                  }

                  widget.onConfirm(
                    fromAddress: pickup.address,
                    toAddress: dropOff.address,
                    fromLocation: pickup.location,
                    toLocation: dropOff.location,
                    selectedDate: selectedDate!,
                    seats: seats, // Pass selected seats
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              'Search',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
  }
}
