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

List<ProfileInfo> profileInfo = [
  ProfileInfo(
    name: "Hai Nguyen",
    email: "benandboo1988@gmail.com",
    phone: "0902590980",
    password: "0902590980",
  ),
];
