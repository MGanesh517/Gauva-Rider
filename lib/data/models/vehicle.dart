class VehicleOrder {
  final String vehicleId;
  final String title;
  final String subTile;
  final String image;
  final int count;
  final int price;

  VehicleOrder({
    required this.vehicleId,
    required this.title,
    required this.subTile,
    required this.image,
    required this.count,
    required this.price,
  });

  factory VehicleOrder.fromJson(Map<String, dynamic> json) => VehicleOrder(
      vehicleId: json['vehicleId'],
      title: json['title'],
      subTile: json['subTile'],
      image: json['image'],
      count: json['count'],
      price: json['price'],
    );

  Map<String, dynamic> toJson() => {
        'vehicleId': vehicleId,
        'title': title,
        'subTile': subTile,
        'image': image,
        'count': count,
        'price': price,
      };
}
