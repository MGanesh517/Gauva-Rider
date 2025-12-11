// import 'package:freezed_annotation/freezed_annotation.dart';
//
//
// @HiveType(typeId: 1)
// @JsonSerializable()
// class Product {
//   @HiveField(0)
//   final int id;
//   @HiveField(1)
//   final String name;
//   @HiveField(2)
//   final String description;
//   @HiveField(3)
//   final int? tenantId;
//   @HiveField(4)
//   final bool isAvailable;
//
//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     this.tenantId,
//     required this.isAvailable,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) =>
//       _$ProductFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ProductToJson(this);
// }
