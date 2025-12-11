import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gauva_userapp/domain/interfaces/driver_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/driver_response/driver_response.dart';
import '../../../data/repositories/driver_repo_impl.dart';
import '../../../data/repositories/interfaces/driver_repo_interface.dart';
import '../../../data/services/driver_service.dart';
import '../viewmodel/driver_notifier.dart';

// Service Provider
final driverServiceProvider = Provider<IDriverService>((ref) => DriverService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final driverRepoProvider = Provider<IDriverRepo>((ref) => DriverRepoImpl(driverService: ref.read(driverServiceProvider)));

// ViewModel Providers
final driversNotifierProvider = StateNotifierProvider.family<DriversNotifier, AppState<DriverResponse>, LatLng?>(
    (ref, latLng) => DriversNotifier(driverRepo: ref.read(driverRepoProvider), userLocation: latLng));
