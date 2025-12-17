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
    Future.microtask(() {
      ref.read(homeMapNotifierProvider.notifier);
      ref.read(carTypeNotifierProvider.notifier).getServicesHome();
      ref.read(bannerProvider.notifier).getBanners();
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    if (!mounted) return; // Check if widget is still mounted

    _mapController = controller;
    final state = ref.read(homeMapNotifierProvider);

    state.manager?.setMapId(controller.mapId);

    if (state.currentLocation != null && mounted) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(state.currentLocation!, 18.0));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapController?.dispose();
  }

  bool isDark() => ref.read(themeModeProvider.notifier).isDarkMode();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeMapNotifierProvider);
    final isDarkMode = isDark();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Map or loading background - full screen
          if (state.currentLocation == null)
            Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: const Center(child: LoadingView()),
            )
          else
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: state.currentLocation!, zoom: 18.0),
              markers: state.markers,
              onCameraMove: state.manager?.onCameraMove,
              onCameraIdle: state.manager?.updateMap,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
            ),
          if (state.currentLocation != null) const ServicesAndPromotional(),
          Positioned(top: 0, left: 0, right: 0, child: HomeMapAppbar(isDark: isDarkMode)),
        ],
      ),
    );
  }
}
