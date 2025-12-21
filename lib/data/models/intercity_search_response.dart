import 'intercity_trip_model.dart';

class IntercitySearchResponse {
  IntercitySearchResponse({
    this.vehicleOptions,
    this.availableTrips,
    this.route,
    this.recommendedVehicle,
    this.recommendationReason,
  });

  IntercitySearchResponse.fromJson(dynamic json) {
    if (json['vehicleOptions'] != null) {
      vehicleOptions = [];
      json['vehicleOptions'].forEach((v) {
        vehicleOptions?.add(VehicleOption.fromJson(v));
      });
    }
    if (json['availableTrips'] != null) {
      availableTrips = [];
      json['availableTrips'].forEach((v) {
        availableTrips?.add(IntercityTripModel.fromJson(v));
      });
    }
    route = json['route'] != null ? RouteInfo.fromJson(json['route']) : null;
    recommendedVehicle = json['recommendedVehicle'];
    recommendationReason = json['recommendationReason'];
  }

  List<VehicleOption>? vehicleOptions;
  List<IntercityTripModel>? availableTrips;
  RouteInfo? route;
  String? recommendedVehicle;
  String? recommendationReason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (vehicleOptions != null) {
      map['vehicleOptions'] = vehicleOptions?.map((v) => v.toJson()).toList();
    }
    if (availableTrips != null) {
      map['availableTrips'] = availableTrips;
    }
    if (route != null) {
      map['route'] = route?.toJson();
    }
    map['recommendedVehicle'] = recommendedVehicle;
    map['recommendationReason'] = recommendationReason;
    return map;
  }
}

class VehicleOption {
  VehicleOption({
    this.vehicleType,
    this.displayName,
    this.description,
    this.imageUrl,
    this.totalPrice,
    this.maxSeats,
    this.minSeats,
    this.currentPerHeadPrice,
    this.availableSeats,
    this.seatsBooked,
    this.seatsRemaining,
    this.seatsTotal,
    this.targetCustomer,
    this.recommendationTag,
    this.isRecommended,
    this.estimatedWaitMinutes,
    this.routeId,
    this.estimatedDeparture,
    this.distanceKm,
    this.estimatedDurationMinutes,
  });

  VehicleOption.fromJson(dynamic json) {
    vehicleType = json['vehicleType'];
    displayName = json['displayName'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    totalPrice = json['totalPrice']?.toDouble() ?? 0.0;
    maxSeats = json['maxSeats'];
    minSeats = json['minSeats'];
    currentPerHeadPrice = json['currentPerHeadPrice']?.toDouble() ?? 0.0;
    availableSeats = json['availableSeats'];
    seatsBooked = json['seatsBooked'];
    seatsRemaining = json['seatsRemaining'];
    seatsTotal = json['seatsTotal'];
    targetCustomer = json['targetCustomer'];
    recommendationTag = json['recommendationTag'];
    isRecommended = json['isRecommended'] ?? false;
    estimatedWaitMinutes = json['estimatedWaitMinutes'];
    routeId = json['routeId'];
    estimatedDeparture = json['estimatedDeparture'];
    distanceKm = json['distanceKm']?.toDouble() ?? 0.0;
    estimatedDurationMinutes = json['estimatedDurationMinutes'];
  }

  String? vehicleType;
  String? displayName;
  String? description;
  String? imageUrl;
  double? totalPrice;
  int? maxSeats;
  int? minSeats;
  double? currentPerHeadPrice;
  int? availableSeats;
  int? seatsBooked;
  int? seatsRemaining;
  int? seatsTotal;
  String? targetCustomer;
  String? recommendationTag;
  bool? isRecommended;
  int? estimatedWaitMinutes;
  int? routeId;
  String? estimatedDeparture;
  double? distanceKm;
  int? estimatedDurationMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicleType'] = vehicleType;
    map['displayName'] = displayName;
    map['description'] = description;
    map['imageUrl'] = imageUrl;
    map['totalPrice'] = totalPrice;
    map['maxSeats'] = maxSeats;
    map['minSeats'] = minSeats;
    map['currentPerHeadPrice'] = currentPerHeadPrice;
    map['availableSeats'] = availableSeats;
    map['seatsBooked'] = seatsBooked;
    map['seatsRemaining'] = seatsRemaining;
    map['seatsTotal'] = seatsTotal;
    map['targetCustomer'] = targetCustomer;
    map['recommendationTag'] = recommendationTag;
    map['isRecommended'] = isRecommended;
    map['estimatedWaitMinutes'] = estimatedWaitMinutes;
    map['routeId'] = routeId;
    map['estimatedDeparture'] = estimatedDeparture;
    map['distanceKm'] = distanceKm;
    map['estimatedDurationMinutes'] = estimatedDurationMinutes;
    return map;
  }
}

class RouteInfo {
  RouteInfo({
    this.routeId,
    this.routeCode,
    this.originName,
    this.destinationName,
    this.distanceKm,
    this.estimatedDurationMinutes,
  });

  RouteInfo.fromJson(dynamic json) {
    routeId = json['routeId'];
    routeCode = json['routeCode'];
    originName = json['originName'];
    destinationName = json['destinationName'];
    distanceKm = json['distanceKm']?.toDouble() ?? 0.0;
    estimatedDurationMinutes = json['estimatedDurationMinutes'];
  }

  int? routeId;
  String? routeCode;
  String? originName;
  String? destinationName;
  double? distanceKm;
  int? estimatedDurationMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['routeId'] = routeId;
    map['routeCode'] = routeCode;
    map['originName'] = originName;
    map['destinationName'] = destinationName;
    map['distanceKm'] = distanceKm;
    map['estimatedDurationMinutes'] = estimatedDurationMinutes;
    return map;
  }
}
