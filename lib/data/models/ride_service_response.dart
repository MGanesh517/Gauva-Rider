class RideServiceResponse {
  RideServiceResponse({
    this.message,
    this.data,
    this.total,});

  RideServiceResponse.fromJson(dynamic json) {
    // Handle if json is a Map
    if (json is Map) {
      message = json['message'];
      total = json['total'];
      // Handle new API format: {total: X, services: [...]}
      if (json['services'] != null && json['data'] == null) {
        // New format: services at root level
        data = Data.fromJson({'services': json['services']});
      } else {
        // Old format: services inside data
        data = json['data'] != null ? Data.fromJson(json['data']) : null;
      }
    } else {
      // If json is not a Map, set defaults
      message = null;
      total = null;
      data = null;
    }
  }
  String? message;
  Data? data;
  num? total;
  RideServiceResponse copyWith({  String? message,
    Data? data,
    num? total,
  }) => RideServiceResponse(  message: message ?? this.message,
    data: data ?? this.data,
    total: total ?? this.total,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['total'] = total;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
    this.servicesList,
    this.distance,
    this.duration,});

  Data.fromJson(dynamic json) {
    if (json['services'] != null) {
      servicesList = [];
      json['services'].forEach((v) {
        servicesList?.add(Services.fromJson(v));
      });
    }
    distance = json['distance'];
    duration = json['duration'];
  }
  List<Services>? servicesList;
  String? distance;
  String? duration;
  Data copyWith({  List<Services>? services,
    String? distance,
    String? duration,
  }) => Data(  servicesList: services ?? servicesList,
    distance: distance ?? this.distance,
    duration: duration ?? this.duration,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (servicesList != null) {
      map['services'] = servicesList?.map((v) => v.toJson()).toList();
    }
    map['distance'] = distance;
    map['duration'] = duration;
    return map;
  }

}

class Services {
  Services({
    this.id,
    this.serviceId,
    this.name,
    this.displayName,
    this.description,
    this.icon,
    this.iconUrl,
    this.capacity,
    this.displayOrder,
    this.isActive,
    this.vehicleType,
    this.estimatedArrival,
    this.baseFare,
    this.perKmRate,
    this.perMinRate,
    this.minimumFare,
    this.cancellationFee,
    this.maxDistance,
    this.maxWaitTime,
    this.category,
    this.isIntercity,
    // Legacy fields for backward compatibility
    this.logo,
    this.personCapacity,
    this.minimumFee,
    this.serviceFare,
    this.costAfterCoupon,
    this.isCouponApplicable,
    this.additionalFee,
    this.totalFare,});

  Services.fromJson(dynamic json) {
    // New API fields
    id = json['id'];
    serviceId = json['serviceId'];
    name = json['name'];
    displayName = json['displayName'];
    description = json['description'];
    icon = json['icon'];
    iconUrl = json['iconUrl'];
    capacity = json['capacity'];
    displayOrder = json['displayOrder'];
    isActive = json['isActive'];
    vehicleType = json['vehicleType'];
    estimatedArrival = json['estimatedArrival'];
    baseFare = json['baseFare'];
    perKmRate = json['perKmRate'];
    perMinRate = json['perMinRate'];
    minimumFare = json['minimumFare'];
    cancellationFee = json['cancellationFee'];
    maxDistance = json['maxDistance'];
    maxWaitTime = json['maxWaitTime'];
    category = json['category'];
    isIntercity = json['isIntercity'];
    // Legacy fields (for backward compatibility)
    logo = json['logo'] ?? json['iconUrl'];
    personCapacity = json['person_capacity'] ?? json['capacity'];
    minimumFee = json['minimum_fee'] ?? json['minimumFare'];
    serviceFare = json['service_fare'] ?? json['total'];
    // costAfterCoupon can come from multiple fields: finalTotal (new API), cost_after_coupon (old), or costAfterCoupon (transformed)
    costAfterCoupon = json['costAfterCoupon'] ?? json['finalTotal'] ?? json['cost_after_coupon'];
    isCouponApplicable = json['is_coupon_applicable'] ?? (json['appliedCoupon'] != null);
    additionalFee = json['additional_fee'];
    // totalFare can come from multiple fields: finalTotal (new API), total_fare (old), or totalFare (transformed)
    totalFare = json['totalFare'] ?? json['finalTotal'] ?? json['total'] ?? json['total_fare'];
  }
  num? id;
  String? serviceId;
  String? name;
  String? displayName;
  String? description;
  String? icon;
  String? iconUrl;
  num? capacity;
  num? displayOrder;
  bool? isActive;
  String? vehicleType;
  String? estimatedArrival;
  num? baseFare;
  num? perKmRate;
  num? perMinRate;
  num? minimumFare;
  num? cancellationFee;
  num? maxDistance;
  num? maxWaitTime;
  String? category;
  bool? isIntercity;
  // Legacy fields
  String? logo;
  num? personCapacity;
  num? minimumFee;
  num? serviceFare;
  num? costAfterCoupon;
  bool? isCouponApplicable;
  num? additionalFee;
  num? totalFare;
  
  // Getter for display name (prefer displayName, fallback to name)
  String get displayNameOrName => displayName ?? name ?? '';
  
  // Getter for icon (prefer icon emoji, fallback to iconUrl)
  String? get iconDisplay => icon ?? iconUrl;
  
  Services copyWith({  num? id,
    String? serviceId,
    String? name,
    String? displayName,
    String? description,
    String? icon,
    String? iconUrl,
    num? capacity,
    num? displayOrder,
    bool? isActive,
    String? vehicleType,
    String? estimatedArrival,
    num? baseFare,
    num? perKmRate,
    num? perMinRate,
    num? minimumFare,
    num? cancellationFee,
    num? maxDistance,
    num? maxWaitTime,
    String? category,
    bool? isIntercity,
    String? logo,
    num? personCapacity,
    num? minimumFee,
    num? serviceFare,
    num? costAfterCoupon,
    bool? isCouponApplicable,
    num? additionalFee,
    num? totalFare,
  }) => Services(  id: id ?? this.id,
    serviceId: serviceId ?? this.serviceId,
    name: name ?? this.name,
    displayName: displayName ?? this.displayName,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    iconUrl: iconUrl ?? this.iconUrl,
    capacity: capacity ?? this.capacity,
    displayOrder: displayOrder ?? this.displayOrder,
    isActive: isActive ?? this.isActive,
    vehicleType: vehicleType ?? this.vehicleType,
    estimatedArrival: estimatedArrival ?? this.estimatedArrival,
    baseFare: baseFare ?? this.baseFare,
    perKmRate: perKmRate ?? this.perKmRate,
    perMinRate: perMinRate ?? this.perMinRate,
    minimumFare: minimumFare ?? this.minimumFare,
    cancellationFee: cancellationFee ?? this.cancellationFee,
    maxDistance: maxDistance ?? this.maxDistance,
    maxWaitTime: maxWaitTime ?? this.maxWaitTime,
    category: category ?? this.category,
    isIntercity: isIntercity ?? this.isIntercity,
    logo: logo ?? this.logo,
    personCapacity: personCapacity ?? this.personCapacity,
    minimumFee: minimumFee ?? this.minimumFee,
    serviceFare: serviceFare ?? this.serviceFare,
    costAfterCoupon: costAfterCoupon ?? this.costAfterCoupon,
    isCouponApplicable: isCouponApplicable ?? this.isCouponApplicable,
    additionalFee: additionalFee ?? this.additionalFee,
    totalFare: totalFare ?? this.totalFare,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['serviceId'] = serviceId;
    map['name'] = name;
    map['displayName'] = displayName;
    map['description'] = description;
    map['icon'] = icon;
    map['iconUrl'] = iconUrl;
    map['capacity'] = capacity;
    map['displayOrder'] = displayOrder;
    map['isActive'] = isActive;
    map['vehicleType'] = vehicleType;
    map['estimatedArrival'] = estimatedArrival;
    map['baseFare'] = baseFare;
    map['perKmRate'] = perKmRate;
    map['perMinRate'] = perMinRate;
    map['minimumFare'] = minimumFare;
    map['cancellationFee'] = cancellationFee;
    map['maxDistance'] = maxDistance;
    map['maxWaitTime'] = maxWaitTime;
    map['category'] = category;
    map['isIntercity'] = isIntercity;
    return map;
  }

}