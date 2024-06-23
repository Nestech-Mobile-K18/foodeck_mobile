class SignUpRequest {
  final String email;
  final String password;
  final String name;
  final String phone;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return SignUpRequest(
      // id: json['id'],
      phone: json['phone'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'phone': phone,
      'email': email,
      'name': name,
      'password': password,
    };
  }
}

class VerifyRequest {
  final String email;
  final String token;

  VerifyRequest({
    required this.email,
    required this.token,
  });

  factory VerifyRequest.fromJson(Map<String, dynamic> json) {
    return VerifyRequest(
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
    };
  }
}
