import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final supabase = Supabase.instance.client;

  Future<AuthResponse?> requestSignInWithIdToken(
      OAuthProvider oAuth, String? idToken, String? accessToken) async {
    final response = await supabase.auth.signInWithIdToken(
      provider: oAuth,
      idToken: idToken ?? '',
      accessToken: accessToken ?? '',
    );
    return response;
  }

  Future<void> requestUpSert(
      Map<String, dynamic> userData, String tableSupabase) async {
    await supabase.from(tableSupabase).upsert(userData);
  }

  Future<void> requestSignInWithOAuth(OAuthProvider oAuth) async {
    await supabase.auth.signInWithOAuth(
      oAuth,
    );
  }

  Future<AuthResponse?> requestSignInWithEmail(
      String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  Future<bool> isEmailRegistered(String email) async {
    final response =
        await supabase.from('users').select('id').eq('email', email);

    return response.indexed.isNotEmpty && response != null;
  }

  Future<void> requestResetPasswordForEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<List<Map<String, dynamic>>?> requestSelected(
      String tableSupabase, String columnName) async {
    var response = await supabase.from(tableSupabase).select(columnName);
    return response;
  }

  Future<void> requestUpdate(
      {required String tableSupabase,
      required Map<String, String> updateData,
      required String nameColumn,
      required String equalString}) async {
    await supabase
        .from(tableSupabase)
        .update(updateData)
        .eq(nameColumn, equalString);
  }

  Future<AuthResponse?> requestVerifyOTP(
      {required String token,
      required OtpType otpType,
      required String? email}) async {
    final AuthResponse response = await supabase.auth
        .verifyOTP(token: token, type: otpType, email: email);
    return response;
  }

  Future<void> requestResendOTP(String email) async {
    await supabase.auth.signInWithOtp(
      email: email,
    );
  }

  Future<AuthResponse?> requestSignUp(
      {required String email, required String password}) async {
    final response =
        await supabase.auth.signUp(email: email, password: password);
    return response;
  }

  Future<void> requestInsert(
      {required String tableSupabase,
      required Map<String, dynamic> userData}) async {
    await supabase.from(tableSupabase).insert(userData);
  }
}
