import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/main.dart';
import 'package:template/src/features/signup/data/model.dart';

class SignUpService {
  // login with email
  Future<String?> signup(SignUpRequest request) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
          email: request.email,
          password: request.password,
          data: {
            'name_user': request.name,
            'phone': request.phone,
            'type': 'CUSTOMER'
          });
      // if (res.user?.id != null) {

      // }
      return response.user?.id;
    } catch (error) {
      print(error);
      return null;
    }
  }

  // verify
  Future<void> verify(VerifyRequest request) async {
    try {
      // final AuthResponse response = 
      await supabase.auth.verifyOTP(
          type: OtpType.email, token: request.token, email: request.email);
      // return response.user?.id;
    } catch (error) {
      print(error);
      // return null;
    }
  }
}
