class FavouriteLocationType {
  final int? value;
  final String? name;
  final String? logoUrl;
  final bool isSelected;

  FavouriteLocationType({
     this.value,
     this.name,
     this.logoUrl,
    this.isSelected = false,
  });

  factory FavouriteLocationType.fromMap(Map<String, dynamic> map) => FavouriteLocationType(
      value: map['value'],
      name: map['name'],
      logoUrl: map['logo_url'],
    );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FavouriteLocationType &&
              runtimeType == other.runtimeType &&
              value == other.value &&
              name == other.name &&
              logoUrl == other.logoUrl;

  // @override
  // int get hashCode => value.hashCode ^ name.hashCode ^ logoUrl.hashCode;

  @override
  int get hashCode =>
      (value?.hashCode ?? 0) ^
      (name?.hashCode ?? 0) ^
      (logoUrl?.hashCode ?? 0);

}
