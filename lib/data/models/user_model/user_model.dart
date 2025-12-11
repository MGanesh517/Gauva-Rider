class User {
  User({
    this.id,
    this.name,
    this.countryIso,
    this.gender,
    this.address,
    this.email,
    this.mobile,
    this.emailVerified,
    this.otpVerified,
    this.status,
    this.profilePicture,});

  User.fromJson(dynamic json) {
    // Handle different ID formats (String UUID, num, or null)
    final idValue = json['id'];
    if (idValue == null) {
      id = null;
    } else if (idValue is num) {
      id = idValue;
    } else if (idValue is String) {
      // Try to parse numeric string, otherwise use hashCode
      id = num.tryParse(idValue) ?? idValue.hashCode;
    } else {
      id = idValue.hashCode;
    }
    
    name = json['name'];
    countryIso = json['country_iso'];
    gender = json['gender'];
    address = json['address'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerified = json['email_verified'];
    otpVerified = json['otp_verified'];
    status = json['status'];
    profilePicture = json['profile_picture'];
  }
  num? id;
  String? name;
  String? countryIso;
  String? gender;
  String? address;
  String? email;
  String? mobile;
  bool? emailVerified;
  bool? otpVerified;
  String? status;
  String? profilePicture;
  User copyWith({  num? id,
    String? name,
    String? countryIso,
    String? gender,
    String? address,
    String? email,
    String? mobile,
    bool? emailVerified,
    bool? otpVerified,
    String? status,
    String? profilePicture,
  }) => User(  id: id ?? this.id,
    name: name ?? this.name,
    countryIso: countryIso ?? this.countryIso,
    gender: gender ?? this.gender,
    address: address ?? this.address,
    email: email ?? this.email,
    mobile: mobile ?? this.mobile,
    emailVerified: emailVerified ?? this.emailVerified,
    otpVerified: otpVerified ?? this.otpVerified,
    status: status ?? this.status,
    profilePicture: profilePicture ?? this.profilePicture,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['country_iso'] = countryIso;
    map['gender'] = gender;
    map['address'] = address;
    map['email'] = email;
    map['mobile'] = mobile;
    map['email_verified'] = emailVerified;
    map['otp_verified'] = otpVerified;
    map['status'] = status;
    map['profile_picture'] = profilePicture;
    return map;
  }

}