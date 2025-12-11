class PaymentMethod {
  final int id;
  final String name;
  final String logo;

  PaymentMethod({required this.id, required this.name, required this.logo});

  factory PaymentMethod.fromMap(Map<String, dynamic> map) => PaymentMethod(
      id: map['id'],
      name: map['value'],
      logo: map['logo'],
    );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          logo == other.logo;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode;
}
