class Rider {
  Rider({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.profilePicture,});

  Rider.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    profilePicture = json['profile_picture'];
  }
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? profilePicture;
  Rider copyWith({  int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? profilePicture,
  }) => Rider(  id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    mobile: mobile ?? this.mobile,
    profilePicture: profilePicture ?? this.profilePicture,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['profile_picture'] = profilePicture;
    return map;
  }

}
