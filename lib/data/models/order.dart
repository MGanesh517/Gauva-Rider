// class Order {
//   final String id;
//   final String status;
//   final OrderDriver driver;
//   final OrderService service;
//
//   Order({
//     required this.id,
//     required this.status,
//     required this.driver,
//     required this.service,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'],
//       status: json['status'],
//       driver: OrderDriver.fromJson(json['driver']),
//       service: OrderService.fromJson(json['service']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'status': status,
//       'driver': driver.toJson(),
//       'service': service.toJson(),
//     };
//   }
// }
//
// class OrderDriver {
//   final int driverId;
//   final String driverName;
//   final String driverImage;
//   final int driverRating;
//   final String driverPhone;
//   final String serviceCategory;
//
//   OrderDriver({
//     required this.driverId,
//     required this.driverName,
//     required this.driverImage,
//     required this.driverRating,
//     required this.driverPhone,
//     required this.serviceCategory,
//   });
//
//   factory OrderDriver.fromJson(Map<String, dynamic> json) {
//     return OrderDriver(
//       driverId: json['driverId'],
//       driverName: json['driverName'],
//       driverImage: json['driverImage'],
//       driverRating: json['driverRating'],
//       driverPhone: json['driverPhone'],
//       serviceCategory: json['serviceCategory'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'driverId': driverId,
//       'driverName': driverName,
//       'driverImage': driverImage,
//       'driverRating': driverRating,
//       'driverPhone': driverPhone,
//       'serviceCategory': serviceCategory,
//     };
//   }
// }
//
// class OrderService {
//   final int serviceId;
//   final String serviceName;
//   final int servicePrice;
//   final String serviceImage;
//   final String vehicleModel;
//   final String vehicleColor;
//   final String vehiclePlateNumber;
//
//   OrderService(
//       {required this.serviceId,
//       required this.serviceName,
//       required this.servicePrice,
//       required this.serviceImage,
//       required this.vehicleModel,
//       required this.vehicleColor,
//       required this.vehiclePlateNumber});
//
//   factory OrderService.fromJson(Map<String, dynamic> json) {
//     return OrderService(
//       serviceId: json['serviceId'],
//       serviceName: json['serviceName'],
//       servicePrice: json['servicePrice'],
//       serviceImage: json['serviceImage'],
//       vehicleModel: json['vehicleModel'],
//       vehicleColor: json['vehicleColor'],
//       vehiclePlateNumber: json['vehiclePlateNumber'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'serviceId': serviceId,
//       'serviceName': serviceName,
//       'servicePrice': servicePrice,
//       'serviceImage': serviceImage,
//       'vehicleModel': vehicleModel,
//       'vehicleColor': vehicleColor,
//       'vehiclePlateNumber': vehiclePlateNumber
//     };
//   }
// }
