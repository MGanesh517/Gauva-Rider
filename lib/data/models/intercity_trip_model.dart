class IntercityTripModel {
  int? tripId;
  String? tripCode;
  String? driverName;
  int? driverId;
  String? driverPhone;
  double? driverRating;
  String? vehicleType;
  String? vehicleDisplayName;
  String? vehicleNumber;
  String? vehicleModel;
  String? status;
  int? availableSeats;
  int? totalSeats;
  int? seatsBooked;
  int? minSeats;
  double? currentPerHeadPrice;
  double? projectedPriceIfYouJoin; // Price if user joins (dynamic pricing)
  double? totalPrice;
  String? pickupAddress;
  String? dropAddress;
  String? scheduledDeparture;
  String? estimatedArrivalTime;
  int? estimatedArrivalMinutes;
  int? countdownSecondsRemaining;
  String? priceMessage; // e.g., "Save 50rs if you join!"
  bool? canJoin;
  String? routeCode;
  double? distanceKm;
  int? estimatedDurationMinutes;

  IntercityTripModel({
    this.tripId,
    this.tripCode,
    this.driverName,
    this.driverId,
    this.driverPhone,
    this.driverRating,
    this.vehicleType,
    this.vehicleDisplayName,
    this.vehicleNumber,
    this.vehicleModel,
    this.status,
    this.availableSeats,
    this.totalSeats,
    this.seatsBooked,
    this.minSeats,
    this.currentPerHeadPrice,
    this.projectedPriceIfYouJoin,
    this.totalPrice,
    this.pickupAddress,
    this.dropAddress,
    this.scheduledDeparture,
    this.estimatedArrivalTime,
    this.estimatedArrivalMinutes,
    this.countdownSecondsRemaining,
    this.priceMessage,
    this.canJoin,
    this.routeCode,
    this.distanceKm,
    this.estimatedDurationMinutes,
  });

  IntercityTripModel.fromJson(Map<String, dynamic> json) {
    tripId = json['tripId'];
    tripCode = json['tripCode'];
    // Driver info might be flat or nested depending on API (HTML shows flat or nested in driver object)
    // The HTML search results example shows flattened or mix.
    // "driverName": "...", "driverId": ...
    driverName = json['driverName'];
    driverId = json['driverId'];
    driverPhone = json['driverPhone'];
    driverRating = json['driverRating']?.toDouble();

    // If driver info is in 'driver' object (as seen in some HTML parts)
    if (json['driver'] != null && json['driver'] is Map) {
      final driver = json['driver'];
      driverName = driver['name'] ?? driverName;
      driverPhone = driver['phone'] ?? driverPhone;
      driverRating = driver['rating']?.toDouble() ?? driverRating;
      vehicleNumber = driver['vehicleNumber'] ?? vehicleNumber;
      vehicleModel = driver['vehicleModel'] ?? vehicleModel;
    }

    vehicleType = json['vehicleType'];
    vehicleDisplayName = json['vehicleDisplayName'];
    vehicleNumber = json['vehicleNumber'] ?? vehicleNumber;
    vehicleModel = json['vehicleModel'] ?? vehicleModel;
    status = json['status'];
    availableSeats = json['availableSeats'];
    totalSeats = json['totalSeats'];
    seatsBooked = json['seatsBooked'];
    minSeats = json['minSeats'];
    currentPerHeadPrice = json['currentPerHeadPrice']?.toDouble();
    projectedPriceIfYouJoin = json['projectedPriceIfYouJoin']?.toDouble();
    totalPrice = json['totalPrice']?.toDouble();
    pickupAddress = json['pickupAddress'];
    dropAddress = json['dropAddress'];
    scheduledDeparture = json['scheduledDeparture'];
    estimatedArrivalTime = json['estimatedArrivalTime'];
    estimatedArrivalMinutes = json['estimatedArrivalMinutes'];
    countdownSecondsRemaining = json['countdownSecondsRemaining'];
    priceMessage = json['priceMessage'];
    canJoin = json['canJoin'];
    routeCode = json['routeCode'];
    distanceKm = json['distanceKm']?.toDouble();
    estimatedDurationMinutes = json['estimatedDurationMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tripId'] = tripId;
    data['tripCode'] = tripCode;
    data['driverName'] = driverName;
    data['driverId'] = driverId;
    data['driverPhone'] = driverPhone;
    data['driverRating'] = driverRating;
    data['vehicleType'] = vehicleType;
    data['vehicleDisplayName'] = vehicleDisplayName;
    data['vehicleNumber'] = vehicleNumber;
    data['vehicleModel'] = vehicleModel;
    data['status'] = status;
    data['availableSeats'] = availableSeats;
    data['totalSeats'] = totalSeats;
    data['seatsBooked'] = seatsBooked;
    data['minSeats'] = minSeats;
    data['currentPerHeadPrice'] = currentPerHeadPrice;
    data['projectedPriceIfYouJoin'] = projectedPriceIfYouJoin;
    data['totalPrice'] = totalPrice;
    data['pickupAddress'] = pickupAddress;
    data['dropAddress'] = dropAddress;
    data['scheduledDeparture'] = scheduledDeparture;
    data['estimatedArrivalTime'] = estimatedArrivalTime;
    data['estimatedArrivalMinutes'] = estimatedArrivalMinutes;
    data['countdownSecondsRemaining'] = countdownSecondsRemaining;
    data['priceMessage'] = priceMessage;
    data['canJoin'] = canJoin;
    data['routeCode'] = routeCode;
    data['distanceKm'] = distanceKm;
    data['estimatedDurationMinutes'] = estimatedDurationMinutes;
    return data;
  }
}
