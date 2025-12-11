
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/config_response.payment_method.dart';
import '../../../data/models/order_response/order_model/service_option/service_options.dart';

class SelectedPaymentNotifier extends StateNotifier<PaymentMethod?> {
  SelectedPaymentNotifier() : super(null);

  void selectPaymentMethod(PaymentMethod? paymentMethod) {
    state = paymentMethod;
  }

  void reset() => state = null;
}

class SelectedRideNotifier extends StateNotifier<List<ServiceOption>> {
  SelectedRideNotifier() : super([]);

  void toggleRide(ServiceOption ride) {
    if (state.contains(ride)) {
      removeRide(ride);
    } else {
      addRide(ride);
    }
  }

  void addRide(ServiceOption ride) {
    final rides = state
    ..add(ride);
    state = rides;
  }

  void removeRide(ServiceOption ride) {
    final rides = state
    ..remove(ride);
    state = rides;
  }

  List<num?> getRideIds() => state.map((e) => e.id).toList();

  void reset() => state = [];
}

class SelectedWaitTimeNotifier extends StateNotifier<int?> {
  SelectedWaitTimeNotifier() : super(null);

  void setSelectedWaitTime(int? waitTime) => state = waitTime;

  void reset() => state = null;
}
