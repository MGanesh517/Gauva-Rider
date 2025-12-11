class IntercityServiceType {
  IntercityServiceType({
    this.id,
    this.vehicleType,
    this.displayName,
    this.totalPrice,
    this.maxSeats,
    this.minSeats,
    this.description,
    this.targetCustomer,
    this.recommendationTag,
    this.displayOrder,
    this.isActive,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  IntercityServiceType.fromJson(dynamic json) {
    id = json['id'];
    vehicleType = json['vehicleType'];
    displayName = json['displayName'];
    totalPrice = json['totalPrice']?.toDouble() ?? 0.0;
    maxSeats = json['maxSeats'];
    minSeats = json['minSeats'];
    description = json['description'];
    targetCustomer = json['targetCustomer'];
    recommendationTag = json['recommendationTag'];
    displayOrder = json['displayOrder'];
    isActive = json['isActive'] ?? true;
    imageUrl = json['imageUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  int? id;
  String? vehicleType;
  String? displayName;
  double? totalPrice;
  int? maxSeats;
  int? minSeats;
  String? description;
  String? targetCustomer;
  String? recommendationTag;
  int? displayOrder;
  bool? isActive;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  IntercityServiceType copyWith({
    int? id,
    String? vehicleType,
    String? displayName,
    double? totalPrice,
    int? maxSeats,
    int? minSeats,
    String? description,
    String? targetCustomer,
    String? recommendationTag,
    int? displayOrder,
    bool? isActive,
    String? imageUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return IntercityServiceType(
      id: id ?? this.id,
      vehicleType: vehicleType ?? this.vehicleType,
      displayName: displayName ?? this.displayName,
      totalPrice: totalPrice ?? this.totalPrice,
      maxSeats: maxSeats ?? this.maxSeats,
      minSeats: minSeats ?? this.minSeats,
      description: description ?? this.description,
      targetCustomer: targetCustomer ?? this.targetCustomer,
      recommendationTag: recommendationTag ?? this.recommendationTag,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['vehicleType'] = vehicleType;
    map['displayName'] = displayName;
    map['totalPrice'] = totalPrice;
    map['maxSeats'] = maxSeats;
    map['minSeats'] = minSeats;
    map['description'] = description;
    map['targetCustomer'] = targetCustomer;
    map['recommendationTag'] = recommendationTag;
    map['displayOrder'] = displayOrder;
    map['isActive'] = isActive;
    map['imageUrl'] = imageUrl;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
