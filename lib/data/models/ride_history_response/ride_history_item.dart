class RideHistoryItem {
  final int? id;
  final UserInfo? user;
  final DriverInfo? driver;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? destinationLatitude;
  final double? destinationLongitude;
  final String? pickupArea;
  final String? destinationArea;
  final double? distance;
  final int? duration;
  final String? status;
  final String? startTime;
  final String? endTime;
  final double? fare;
  final dynamic paymentDetails;
  final int? otp;

  RideHistoryItem({
    this.id,
    this.user,
    this.driver,
    this.pickupLatitude,
    this.pickupLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.pickupArea,
    this.destinationArea,
    this.distance,
    this.duration,
    this.status,
    this.startTime,
    this.endTime,
    this.fare,
    this.paymentDetails,
    this.otp,
  });

  factory RideHistoryItem.fromJson(Map<String, dynamic> json) {
    return RideHistoryItem(
      id: json['id'],
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      driver: json['driver'] != null ? DriverInfo.fromJson(json['driver']) : null,
      pickupLatitude: json['pickupLatitude']?.toDouble(),
      pickupLongitude: json['pickupLongitude']?.toDouble(),
      destinationLatitude: json['destinationLatitude']?.toDouble(),
      destinationLongitude: json['destinationLongitude']?.toDouble(),
      pickupArea: json['pickupArea'],
      destinationArea: json['destinationArea'],
      distance: json['distance']?.toDouble(),
      duration: json['duration'],
      status: json['status'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      fare: json['fare']?.toDouble(),
      paymentDetails: json['paymentDetails'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'driver': driver?.toJson(),
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'destinationLatitude': destinationLatitude,
      'destinationLongitude': destinationLongitude,
      'pickupArea': pickupArea,
      'destinationArea': destinationArea,
      'distance': distance,
      'duration': duration,
      'status': status,
      'startTime': startTime,
      'endTime': endTime,
      'fare': fare,
      'paymentDetails': paymentDetails,
      'otp': otp,
    };
  }
}

class UserInfo {
  final String? id;
  final String? email;
  final String? fullName;
  final String? phone;
  final String? role;

  UserInfo({this.id, this.email, this.fullName, this.phone, this.role});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      email: json['email'],
      fullName: json['fullName'],
      phone: json['phone'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'fullName': fullName, 'phone': phone, 'role': role};
  }
}

class DriverInfo {
  final int? id;
  final String? name;
  final String? email;
  final String? mobile;
  final double? rating;
  final double? latitude;
  final double? longitude;
  final LicenseInfo? license;
  final String? role;
  final VehicleInfo? vehicle;
  final double? totalRevenue;
  final String? accountHolderName;
  final String? bankName;
  final String? accountNumber;
  final String? ifscCode;
  final String? upiId;
  final String? bankAddress;
  final String? bankMobile;
  final String? bankVerificationStatus;
  final String? bankVerificationNotes;
  final String? bankVerifiedAt;

  DriverInfo({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.rating,
    this.latitude,
    this.longitude,
    this.license,
    this.role,
    this.vehicle,
    this.totalRevenue,
    this.accountHolderName,
    this.bankName,
    this.accountNumber,
    this.ifscCode,
    this.upiId,
    this.bankAddress,
    this.bankMobile,
    this.bankVerificationStatus,
    this.bankVerificationNotes,
    this.bankVerifiedAt,
  });

  factory DriverInfo.fromJson(Map<String, dynamic> json) {
    return DriverInfo(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      rating: json['rating']?.toDouble(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      license: json['license'] != null ? LicenseInfo.fromJson(json['license']) : null,
      role: json['role'],
      vehicle: json['vehicle'] != null ? VehicleInfo.fromJson(json['vehicle']) : null,
      totalRevenue: json['totalRevenue']?.toDouble(),
      accountHolderName: json['accountHolderName'],
      bankName: json['bankName'],
      accountNumber: json['accountNumber'],
      ifscCode: json['ifscCode'],
      upiId: json['upiId'],
      bankAddress: json['bankAddress'],
      bankMobile: json['bankMobile'],
      bankVerificationStatus: json['bankVerificationStatus'],
      bankVerificationNotes: json['bankVerificationNotes'],
      bankVerifiedAt: json['bankVerifiedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'license': license?.toJson(),
      'role': role,
      'vehicle': vehicle?.toJson(),
      'totalRevenue': totalRevenue,
      'accountHolderName': accountHolderName,
      'bankName': bankName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'upiId': upiId,
      'bankAddress': bankAddress,
      'bankMobile': bankMobile,
      'bankVerificationStatus': bankVerificationStatus,
      'bankVerificationNotes': bankVerificationNotes,
      'bankVerifiedAt': bankVerifiedAt,
    };
  }
}

class LicenseInfo {
  final int? id;
  final String? licenseNumber;
  final String? licenseState;
  final String? licenseExpirationDate;

  LicenseInfo({this.id, this.licenseNumber, this.licenseState, this.licenseExpirationDate});

  factory LicenseInfo.fromJson(Map<String, dynamic> json) {
    return LicenseInfo(
      id: json['id'],
      licenseNumber: json['licenseNumber'],
      licenseState: json['licenseState'],
      licenseExpirationDate: json['licenseExpirationDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'licenseNumber': licenseNumber,
      'licenseState': licenseState,
      'licenseExpirationDate': licenseExpirationDate,
    };
  }
}

class VehicleInfo {
  final int? id;
  final String? company;
  final String? model;
  final String? color;
  final String? year;
  final String? licensePlate;
  final int? capacity;
  final int? seatCapacity;
  final int? hatchBag;
  final String? fuelType;
  final String? vehicleId;

  VehicleInfo({
    this.id,
    this.company,
    this.model,
    this.color,
    this.year,
    this.licensePlate,
    this.capacity,
    this.seatCapacity,
    this.hatchBag,
    this.fuelType,
    this.vehicleId,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      id: json['id'],
      company: json['company'],
      model: json['model'],
      color: json['color'],
      year: json['year'],
      licensePlate: json['licensePlate'],
      capacity: json['capacity'],
      seatCapacity: json['seatCapacity'],
      hatchBag: json['hatchBag'],
      fuelType: json['fuelType'],
      vehicleId: json['vehicleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'model': model,
      'color': color,
      'year': year,
      'licensePlate': licensePlate,
      'capacity': capacity,
      'seatCapacity': seatCapacity,
      'hatchBag': hatchBag,
      'fuelType': fuelType,
      'vehicleId': vehicleId,
    };
  }
}
