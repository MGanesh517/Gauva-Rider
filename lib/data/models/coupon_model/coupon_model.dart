class CouponModel {
  final int id;
  final String code;
  final String type; // "PERCENT" or "FLAT"
  final double value;
  final double? minFare;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final bool active;

  CouponModel({
    required this.id,
    required this.code,
    required this.type,
    required this.value,
    this.minFare,
    this.startsAt,
    this.endsAt,
    required this.active,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      code: json['code'],
      type: json['type'],
      value: (json['value'] is int) ? (json['value'] as int).toDouble() : json['value'],
      minFare: json['minFare'] != null
          ? (json['minFare'] is int ? (json['minFare'] as int).toDouble() : json['minFare'])
          : null,
      startsAt: json['startsAt'] != null ? DateTime.parse(json['startsAt']) : null,
      endsAt: json['endsAt'] != null ? DateTime.parse(json['endsAt']) : null,
      active: json['active'],
    );
  }
}
