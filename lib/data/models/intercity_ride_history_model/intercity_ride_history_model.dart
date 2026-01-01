class IntercityRideHistoryModel {
  int? id;
  String? tripCode;
  String? status;
  String? pickupAddress;
  String? dropAddress;
  String? scheduledDeparture;
  String? actualDeparture;
  String? actualArrival;
  int? totalSeats;
  int? seatsBooked;
  int? passengersOnboarded;
  num? totalPrice;
  String? vehicleType;

  IntercityRideHistoryModel({
    this.id,
    this.tripCode,
    this.status,
    this.pickupAddress,
    this.dropAddress,
    this.scheduledDeparture,
    this.actualDeparture,
    this.actualArrival,
    this.totalSeats,
    this.seatsBooked,
    this.passengersOnboarded,
    this.totalPrice,
    this.vehicleType,
  });

  IntercityRideHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tripCode = json['tripCode'];
    status = json['status'];
    pickupAddress = json['pickupAddress'];
    dropAddress = json['dropAddress'];
    scheduledDeparture = json['scheduledDeparture'];
    actualDeparture = json['actualDeparture'];
    actualArrival = json['actualArrival'];
    totalSeats = json['totalSeats'];
    seatsBooked = json['seatsBooked'];
    passengersOnboarded = json['passengersOnboarded'];
    totalPrice = json['totalPrice'];
    vehicleType = json['vehicleType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tripCode'] = tripCode;
    data['status'] = status;
    data['pickupAddress'] = pickupAddress;
    data['dropAddress'] = dropAddress;
    data['scheduledDeparture'] = scheduledDeparture;
    data['actualDeparture'] = actualDeparture;
    data['actualArrival'] = actualArrival;
    data['totalSeats'] = totalSeats;
    data['seatsBooked'] = seatsBooked;
    data['passengersOnboarded'] = passengersOnboarded;
    data['totalPrice'] = totalPrice;
    data['vehicleType'] = vehicleType;
    return data;
  }
}
