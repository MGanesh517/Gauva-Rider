class PromotionalSliderModel {
  PromotionalSliderModel({
      this.message, 
      this.data,});

  PromotionalSliderModel.fromJson(dynamic json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Promotions.fromJson(v));
      });
    }
  }
  String? message;
  List<Promotions>? data;
PromotionalSliderModel copyWith({  String? message,
  List<Promotions>? data,
}) => PromotionalSliderModel(  message: message ?? this.message,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Promotions {
  Promotions({
      this.id, 
      this.image,});

  Promotions.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
  }
  num? id;
  String? image;
Promotions copyWith({  num? id,
  String? image,
}) => Promotions(  id: id ?? this.id,
  image: image ?? this.image,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    return map;
  }

}