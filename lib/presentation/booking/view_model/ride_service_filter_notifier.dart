import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/rider_service_state.dart';

class RideServiceFilterNotifier extends StateNotifier<RiderServiceState> {
  RideServiceFilterNotifier()
      : super(
          RiderServiceState(
            pickupLocation: [],
            dropLocation: [],
            waitLocation: [],
            serviceOptionIds: [],
          ),
        );

  void addRideServiceFilter(RiderServiceState riderServiceState) {
    state = riderServiceState;
  }

  void updatePickupLocation(List<double> location) {
    state = state.copyWith(pickupLocation: location);
  }

  void updateDropLocation(List<double> location) {
    state = state.copyWith(dropLocation: location);
  }

  void updateWaitLocation(List<double> location) {
    state = state.copyWith(waitLocation: location);
  }

  RiderServiceState updateServiceOptionIds(List<num?> serviceOptionIds) {
    state = state.copyWith(serviceOptionIds: serviceOptionIds);
    return state;
  }

  RiderServiceState updateCouponCode(String? couponCode) {
    state = state.copyWith(couponCode: couponCode);
    return state;
  }

  RiderServiceState removeCouponCode() {
    state = state.copyWith();
    return state;
  }

  void reset() {
    state = RiderServiceState(
      pickupLocation: [],
      dropLocation: [],
      waitLocation: [],
      serviceOptionIds: [],
    );
  }
}
