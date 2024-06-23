class AccountInfo {
  final String userId;
  final String? password;
  final String name;
  final String? phone;
  final String? avatar;
  final String? typeAuthen;
  final String? email;


  const AccountInfo({
    this.userId = '',
    this.password = '',
    this.name = '',
    this.phone = '',
    this.avatar = '',
    this.typeAuthen = '',
    this.email=''
  });
}

class AuthEmailRequest {
  final String email;
  final String password;

  AuthEmailRequest({
    required this.email,
    required this.password,
  });

  factory AuthEmailRequest.fromJson(Map<String, dynamic> json) {
    return AuthEmailRequest(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
// class UserModel {
//   final String id;

//   final String phone;
//   final String email;
//   final String username;
//   final String password;

//   UserModel({
//     required this.id,
//     required this.phone,
//     required this.email,
//     required this.username,
//     required this.password,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       phone: json['phone'],
//       email: json['email'],
//       username: json['username'],
//       password: json['password'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'phone': phone,
//       'email': email,
//       'username': username,
//       'password': password,
//     };
//   }
// }
