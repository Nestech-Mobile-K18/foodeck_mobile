import '../../../services/table_supbase.dart';

class EditProfileModel {
  late final String? avatarPath;
  final String? name;
  final String? email;
  late final String? phone;
  final String? password;

  EditProfileModel(
      {this.name, this.email, this.phone, this.password, this.avatarPath}) {
    userData = {
      TableSupabase.nameColumn: name,
      TableSupabase.emailColumn: email,
      TableSupabase.phoneColumn: phone,
      TableSupabase.passwordColumn: password,
    };
  }

  late final Map<String, dynamic> userData;
}
