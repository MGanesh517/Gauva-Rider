import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/common/loading_view.dart';
import 'package:gauva_userapp/presentation/dashboard/viewmodel/car_type_notifier.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/home_map_appbar.dart';
import 'package:gauva_userapp/presentation/dashboard/widgets/services_and_promotional.dart';

import '../../account_page/provider/theme_provider.dart';
import '../provider/banner_provider.dart';
import '../provider/home_map_providers.dart';

class HomeMap extends ConsumerStatefulWidget {
  const HomeMap({super.key});

  @override
  ConsumerState<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends ConsumerState<HomeMap> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    // Initialize notifier first (no API call) - this gets location for map
    Future.microtask(() {
      ref.read(homeMapNotifierProvider.notifier);
    });

    // PERFORMANCE OPTIMIZATION: Load map first, then services, then banners
    // This ensures map appears immediately while services/banners load in background

    // Step 1: Map shows immediately (handled by homeMapNotifierProvider initialization)

    // Step 2: Load services after map is visible (delay to let map render first)
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        // Cache check happens inside getServicesHome() - returns instantly if cached
        ref.read(carTypeNotifierProvider.notifier).getServicesHome();
      }
    });

    // Step 3: Load banners after services (further delay)
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        // Cache check happens inside getBanners() - returns instantly if cached
        ref.read(bannerProvider.notifier).getBanners();
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (!mounted) return; // Check if widget is still mounted

    _mapController = controller;
    final state = ref.read(homeMapNotifierProvider);

    // PERFORMANCE OPTIMIZATION: Set map ID without await (non-blocking)
    state.manager?.setMapId(controller.mapId);

    // PERFORMANCE OPTIMIZATION: Animate camera only if location is available
    // Use initialCameraPosition in GoogleMap widget instead of animateCamera for faster initial load
    final location = state.currentLocation;
    if (location != null && mounted) {
      // Use animateCamera for smooth transition, but it's non-blocking
      controller.animateCamera(CameraUpdate.newLatLngZoom(location, 18.0));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.dispose();
  }

  // PERFORMANCE OPTIMIZATION: Cache theme mode to avoid repeated reads
  bool? _cachedIsDarkMode;

  bool isDark() {
    // Cache theme mode for this build cycle
    _cachedIsDarkMode ??= ref.read(themeModeProvider.notifier).isDarkMode();
    return _cachedIsDarkMode!;
  }

  @override
  Widget build(BuildContext context) {
    // PERFORMANCE OPTIMIZATION: Use select to watch only specific state changes
    // This prevents unnecessary rebuilds when other state properties change
    final currentLocation = ref.watch(homeMapNotifierProvider.select((state) => state.currentLocation));
    final markers = ref.watch(homeMapNotifierProvider.select((state) => state.markers));
    // Read manager once (doesn't need to rebuild on changes)
    final manager = ref.read(homeMapNotifierProvider).manager;

    final isDarkMode = isDark();

    // Reset cached theme mode on each build to allow theme changes
    _cachedIsDarkMode = null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Map or loading background - full screen
          // PERFORMANCE OPTIMIZATION: Use cached location value
          if (currentLocation == null)
            Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: const Center(child: LoadingView()),
            )
          else
            GoogleMap(
              onMapCreated: _onMapCreated,
              // PERFORMANCE OPTIMIZATION: Set initial camera position directly
              // This avoids animation delay on first load
              initialCameraPosition: CameraPosition(target: currentLocation, zoom: 18.0),
              markers: markers,
              onCameraMove: manager?.onCameraMove,
              onCameraIdle: manager?.updateMap,
              // PERFORMANCE OPTIMIZATION: Disable unused features for better performance
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              // PERFORMANCE OPTIMIZATION: Optimize map rendering
              mapType: MapType.normal,
              minMaxZoomPreference: const MinMaxZoomPreference(10.0, 20.0),
            ),
          // PERFORMANCE OPTIMIZATION: Only show services when location is available
          if (currentLocation != null) const ServicesAndPromotional(),
          // PERFORMANCE OPTIMIZATION: Use const where possible
          Positioned(top: 0, left: 0, right: 0, child: HomeMapAppbar(isDark: isDarkMode)),
        ],
      ),
    );
  }
}
