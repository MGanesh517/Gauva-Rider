class RiderServiceState {
  final List<double> pickupLocation;
  final List<double> dropLocation;
  final List<double> waitLocation;
  final List<num?> serviceOptionIds;
  final String? pickupAddress;
  final String? dropAddress;
  final String? waitAddress;
  final String? couponCode;
  final String? pickupZoneReadableId;
  final String? dropZoneReadableId;
  final double? distanceKm;
  final int? durationMin;

  RiderServiceState({
    required this.pickupLocation,
    required this.dropLocation,
    required this.waitLocation,
    required this.serviceOptionIds,
    this.pickupAddress,
    this.dropAddress,
    this.waitAddress,
    this.couponCode,
    this.pickupZoneReadableId,
    this.dropZoneReadableId,
    this.distanceKm,
    this.durationMin,
  });

  RiderServiceState copyWith({
    List<double>? pickupLocation,
    List<double>? dropLocation,
    List<double>? waitLocation,
    List<num?>? serviceOptionIds,
    String? pickupAddress,
    String? dropAddress,
    String? waitAddress,
    String? couponCode,
    String? pickupZoneReadableId,
    String? dropZoneReadableId,
    double? distanceKm,
    int? durationMin,
  }) => RiderServiceState(
    pickupLocation: pickupLocation ?? this.pickupLocation,
    dropLocation: dropLocation ?? this.dropLocation,
    waitLocation: waitLocation ?? this.waitLocation,
    serviceOptionIds: serviceOptionIds ?? this.serviceOptionIds,
    pickupAddress: pickupAddress ?? this.pickupAddress,
    dropAddress: dropAddress ?? this.dropAddress,
    waitAddress: waitAddress ?? this.waitAddress,
    couponCode: couponCode ?? this.couponCode,
    pickupZoneReadableId: pickupZoneReadableId ?? this.pickupZoneReadableId,
    dropZoneReadableId: dropZoneReadableId ?? this.dropZoneReadableId,
    distanceKm: distanceKm ?? this.distanceKm,
    durationMin: durationMin ?? this.durationMin,
  );

  Map<String, dynamic> toMap() => {
    'pickup_location[]': pickupLocation,
    'drop_location[]': dropLocation,
    'wait_location[]': waitLocation,
    'service_option_ids[]': serviceOptionIds,
    'coupon_code': couponCode,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RiderServiceState &&
        listEquals(other.pickupLocation, pickupLocation) &&
        listEquals(other.dropLocation, dropLocation) &&
        listEquals(other.waitLocation, waitLocation) &&
        listEquals(other.serviceOptionIds, serviceOptionIds) &&
        other.pickupAddress == pickupAddress &&
        other.dropAddress == dropAddress &&
        other.waitAddress == waitAddress &&
        other.couponCode == couponCode &&
        other.pickupZoneReadableId == pickupZoneReadableId &&
        other.dropZoneReadableId == dropZoneReadableId &&
        other.distanceKm == distanceKm &&
        other.durationMin == durationMin;
  }

  @override
  int get hashCode {
    return pickupLocation.hashCode ^
        dropLocation.hashCode ^
        waitLocation.hashCode ^
        serviceOptionIds.hashCode ^
        pickupAddress.hashCode ^
        dropAddress.hashCode ^
        waitAddress.hashCode ^
        couponCode.hashCode ^
        pickupZoneReadableId.hashCode ^
        dropZoneReadableId.hashCode ^
        distanceKm.hashCode ^
        durationMin.hashCode;
  }
}

bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
