class BannerModel {
  BannerModel({
    this.id,
    this.title,
    this.shortDescription,
    this.redirectLink,
    this.timePeriod,
    this.imageUrl,
    this.active,
    this.displayOrder,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  BannerModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    redirectLink = json['redirectLink'];
    timePeriod = json['timePeriod'];
    imageUrl = json['imageUrl'];
    active = json['active'];
    displayOrder = json['displayOrder'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  num? id;
  String? title;
  String? shortDescription;
  String? redirectLink;
  String? timePeriod;
  String? imageUrl;
  bool? active;
  num? displayOrder;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  BannerModel copyWith({
    num? id,
    String? title,
    String? shortDescription,
    String? redirectLink,
    String? timePeriod,
    String? imageUrl,
    bool? active,
    num? displayOrder,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? updatedAt,
  }) =>
      BannerModel(
        id: id ?? this.id,
        title: title ?? this.title,
        shortDescription: shortDescription ?? this.shortDescription,
        redirectLink: redirectLink ?? this.redirectLink,
        timePeriod: timePeriod ?? this.timePeriod,
        imageUrl: imageUrl ?? this.imageUrl,
        active: active ?? this.active,
        displayOrder: displayOrder ?? this.displayOrder,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['shortDescription'] = shortDescription;
    map['redirectLink'] = redirectLink;
    map['timePeriod'] = timePeriod;
    map['imageUrl'] = imageUrl;
    map['active'] = active;
    map['displayOrder'] = displayOrder;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}

