class AccountInfo {
  final String name;
  final String? email;
  final String? phone;
  final String pass;
  final String id;

  const AccountInfo(
      {required this.name,
      this.email,
      this.phone,
      required this.pass,
      required this.id});
}
