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
}
