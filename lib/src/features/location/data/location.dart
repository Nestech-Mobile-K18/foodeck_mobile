// class LocationInfor {
//   final double? lat;
//   final double? lng;
//   final String? name;
//   final String? street;
//   final String? isoCountryCode;
//   final String? country;
//   final String? subadministrativeArea;
//   final String? thoroughfare;
//   final String? subthoroughfare;

//   const LocationInfor({
//     this.lat,
//     this.lng,
//     this.name,
//     this.street,
//     this.isoCountryCode,
//     this.country,
//     this.subadministrativeArea,
//     this.thoroughfare,
//     this.subthoroughfare,
//   });



//   static LocationInfor empty() {
//     return LocationInfor();
//   }
// }

// class LocationRequest {
//   final String email;
//   final String password;

//   LocationRequest({
//     required this.email,
//     required this.password,
//   });

//   factory AuthEmailRequest.fromJson(Map<String, dynamic> json) {
//     return AuthEmailRequest(
//       // id: json['id'],
//       // phone: json['phone'],
//       email: json['email'],
//       // username: json['username'],
//       password: json['password'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       // 'id': id,
//       // 'phone': phone,
//       'email': email,
//       // 'username': username,
//       'password': password,
//     };
//   }
// }
