class ServiceOptions {
  ServiceOptions({this.serviceOptions});

  List<ServiceOption>? serviceOptions;

  ServiceOptions copyWith({
    List<ServiceOption>? serviceOptions,
  }) => ServiceOptions(
      serviceOptions: serviceOptions ?? this.serviceOptions,
    );

  factory ServiceOptions.fromJson(Map<String, dynamic> json) => ServiceOptions(
      serviceOptions: json['service_options'] != null
          ? List<ServiceOption>.from(
        json['service_options'].map((v) => ServiceOption.fromJson(v)),
      )
          : null,
    );

  Map<String, dynamic> toJson() => {
      if (serviceOptions != null)
        'service_options': serviceOptions!.map((v) => v.toJson()).toList(),
    };
}

class ServiceOption {
  ServiceOption({
    this.id,
    this.name,
    this.description,
    this.type,
    this.additionalFee,
  });

  num? id;
  String? name;
  String? description;
  Type? type;
  num? additionalFee;

  ServiceOption copyWith({
    num? id,
    String? name,
    String? description,
    Type? type,
    num? additionalFee,
  }) => ServiceOption(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      additionalFee: additionalFee ?? this.additionalFee,
    );

  factory ServiceOption.fromJson(Map<String, dynamic> json) => ServiceOption(
      id: json['id'] ?? json['value'],
      name: json['name'],
      description: json['description'],
      type: json['type'] != null ? Type.fromJson(json['type']) : null,
      additionalFee: json['additional_fee'],
    );

  Map<String, dynamic> toJson() => {
      'id': id,
      'name': name,
      'description': description,
      if (type != null) 'type': type!.toJson(),
      'additional_fee': additionalFee,
    };
}

class Type {
  Type({this.value, this.label});

  String? value;
  String? label;

  Type copyWith({
    String? value,
    String? label,
  }) => Type(
      value: value ?? this.value,
      label: label ?? this.label,
    );

  factory Type.fromJson(Map<String, dynamic> json) => Type(
      value: json['value'],
      label: json['label'],
    );

  Map<String, dynamic> toJson() => {
      'value': value,
      'label': label,
    };
}
