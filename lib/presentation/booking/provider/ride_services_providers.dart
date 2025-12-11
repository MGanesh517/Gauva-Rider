import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/ride_service_response.dart';
import '../../../data/repositories/interfaces/ride_service_repo_interface.dart';
import '../../../data/repositories/ride_service_repo_impl.dart';
import '../../../data/services/ride_services_service.dart';
import '../../../domain/interfaces/ride_service_interface.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/apply_coupon_notifier.dart';
import '../view_model/ride_services_notifier.dart';

// Service Provider
final rideServiceProvider =
    Provider<IRideServicesService>((ref) => RideServicesService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final rideServicesRepoProvider = Provider<IRideServicesRepo>((ref) => RiderServiceRepoImpl(ref.read(rideServiceProvider)));

// View Model Providers
final rideServicesNotifierProvider = StateNotifierProvider<RideServicesNotifier, AppState<RideServiceResponse>>(
    (ref) => RideServicesNotifier(ref: ref, rideServicesRepo: ref.read(rideServicesRepoProvider)));

final applyCouponProvider = StateNotifierProvider<ApplyCouponNotifier, AppState<CommonResponse>>(
        (ref) => ApplyCouponNotifier(ref: ref, repo: ref.read(rideServicesRepoProvider)));

