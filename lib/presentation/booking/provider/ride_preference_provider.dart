import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gauva_userapp/data/repositories/interfaces/ride_preference_repo_interface.dart';
import 'package:gauva_userapp/data/repositories/ride_preference_repo_impl.dart';
import 'package:gauva_userapp/domain/interfaces/ride_preference_service_interface.dart';
import 'package:gauva_userapp/presentation/auth/provider/auth_providers.dart';
import 'package:gauva_userapp/presentation/booking/view_model/ride_preference_notifier.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/order_response/order_model/service_option/service_options.dart';
import '../../../data/services/ride_preference_service.dart';


// Service Provider
final ridePreferenceServiceProvider = Provider<IRidePreferenceService>((ref) => RidePreferenceService(dioClient: ref.read(dioClientProvider)));

// Repo Provider
final ridePreferenceRepoProvider = Provider<IRidePreferenceRepo>((ref) => RidePreferenceRepoImpl(service: ref.read(ridePreferenceServiceProvider)));

// ViewModel Providers
final ridePreferenceProvider = StateNotifierProvider<RidePreferenceNotifier, AppState<List<ServiceOption>>>(
        (ref) => RidePreferenceNotifier(repo: ref.read(ridePreferenceRepoProvider),));
