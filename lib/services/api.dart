import 'package:supabase_flutter/supabase_flutter.dart';

class API {
  final supabase = Supabase.instance.client;
  late final SupabaseClient supabaseClient;

  Future<String?> responseUserId() async {
    String? getUserId;
    // Lấy thông tin về người dùng hiện tại đang đăng nhập
    var currentUser = supabase.auth.currentUser;

    // Kiểm tra xem người dùng có tồn tại không
    if (currentUser != null) {
      // Lấy id của người dùng hiện tại
      getUserId = currentUser.id.toString();
    }

    return getUserId;
  }

  /// Request sign in with ID token.
  Future<AuthResponse?> requestSignInWithIdToken(
      OAuthProvider oAuth, String? idToken, String? accessToken) async {
    final response = await supabase.auth.signInWithIdToken(
      provider: oAuth,
      idToken: idToken ?? '',
      accessToken: accessToken ?? '',
    );
    return response;
  }

  /// Request to upsert user data into a specified Supabase table.
  Future<void> requestUpSert(
      Map<String, dynamic> userData, String tableSupabase) async {
    await supabase.from(tableSupabase).upsert(userData);
  }

  /// Request sign in with OAuth provider.
  Future<void> requestSignInWithOAuth(OAuthProvider oAuth) async {
    await supabase.auth.signInWithOAuth(
      oAuth,
    );
  }

  /// Request sign in with email and password.
  Future<AuthResponse?> requestSignInWithEmail(
      String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  /// Check if an email is registered with an email provider.
  Future<bool> isEmailRegisteredByEmail(String email) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('email', email)
        .eq('provider', 'Email');

    return response.indexed.isNotEmpty && response != null;
  }

  /// Check if an email is registered with a Google provider.
  Future<bool> isEmailRegisteredByGoogle(String email) async {
    final response = await supabase
        .from('users')
        .select()
        .eq('email', email)
        .eq('provider', 'Google');

    return response.indexed.isNotEmpty && response != null;
  }

  /// Request to reset password for a specified email.
  Future<void> requestResetPasswordForEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  /// Request selected data from a specified table.
  Future<List<Map<String, dynamic>>?> requestSelected(
      String tableSupabase, String columnName) async {
    var response = await supabase.from(tableSupabase).select(columnName);
    return response;
  }

  /// Request selected data from a specified table based on query conditions.
  Future<List<Map<String, dynamic>>> requestSelectedByQuery(
      String tableSupabase,
      List<String> columnNames,
      String columnQuery,
      Object value) async {
    var response = await supabase
        .from(tableSupabase)
        .select(columnNames.join(", ")) // Chọn nhiều cột
        .eq(columnQuery, value);

    // Convert response data to List<Map<String, dynamic>>.
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(response);
    return dataList;
  }

  /// Request to update data in a specified table.
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

  /// Request to verify OTP (One-Time Password).
  Future<AuthResponse?> requestVerifyOTP(
      {required String token,
      required OtpType otpType,
      required String? email}) async {
    final AuthResponse response = await supabase.auth
        .verifyOTP(token: token, type: otpType, email: email);
    return response;
  }

  /// Request to resend OTP (One-Time Password) to a specified email.
  Future<void> requestResendOTP(String email) async {
    await supabase.auth.signInWithOtp(
      email: email,
    );
  }

  /// Request to sign up a new user with email and password.
  Future<AuthResponse?> requestSignUp(
      {required String email, required String password}) async {
    final response =
        await supabase.auth.signUp(email: email, password: password);
    return response;
  }

  /// Request to insert data into a specified table.
  Future<void> requestInsert(
      {required String tableSupabase,
      required Map<String, dynamic> userData}) async {
    await supabase.from(tableSupabase).insert(userData);
  }

  /// Request the ID of the current authenticated user.
  Future<String?> requestQueryIdAuthen() async {
    final response = await supabase.auth.currentUser?.id;
    return response;
  }
}
