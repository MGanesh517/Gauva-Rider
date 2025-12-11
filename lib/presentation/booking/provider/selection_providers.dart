import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/rider_service_state.dart';
import '../../../data/models/order_response/order_model/service_option/service_options.dart';
import '../view_model/ride_service_filter_notifier.dart';
import '../view_model/selection_notifier.dart';

final selectedWaitTimeNotifierProvider =
    StateNotifierProvider<SelectedWaitTimeNotifier, int?>((ref) => SelectedWaitTimeNotifier());

final selectedRideNotifierProvider =
    StateNotifierProvider<SelectedRideNotifier, List<ServiceOption>>((ref) => SelectedRideNotifier());

final rideServiceFilterNotiferProvider =
    StateNotifierProvider<RideServiceFilterNotifier, RiderServiceState>((ref) => RideServiceFilterNotifier());
