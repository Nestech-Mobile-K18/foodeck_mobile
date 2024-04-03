class ProfileInfo {
  final String name;
  final String email;
  final String phone;
  final String? password;

  ProfileInfo({
    required this.name,
    required this.email,
    required this.phone,
    this.password,
  });
}

List<ProfileInfo> profileInfo = [];
