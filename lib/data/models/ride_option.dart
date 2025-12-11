import 'package:flutter/material.dart';

class RideOption {
  final int id;
  final String name;
  final IconData icon;
  final double? price;
  final String? description;

  RideOption(
      {required this.id,
      required this.name,
      required this.icon,
      this.price,
      this.description});

  factory RideOption.fromJson(Map<String, dynamic> json) => RideOption(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      price: json['price'],
      description: json['description'],
    );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'price': price,
        'description': description,
      };

  @override
  String toString() => 'RideOption{id: $id, name: $name, icon: $icon, price: $price, description: $description}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RideOption) return false;
    final RideOption rideOption = other;
    return id == rideOption.id &&
        name == rideOption.name &&
        icon == rideOption.icon &&
        price == rideOption.price &&
        description == rideOption.description;
  }

  @override
  int get hashCode => id.hashCode ^
        name.hashCode ^
        icon.hashCode ^
        price.hashCode ^
        description.hashCode;
}
