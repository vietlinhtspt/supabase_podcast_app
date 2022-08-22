import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final SharedPreferences preference;

  AuthRepository(this.preference);

  Future<GotrueResponse> logout() async {
    final supabase = Supabase.instance.client;

    return supabase.auth.signOut();
  }

  Future<GotrueSessionResponse> loginWithEmail({
    required String email,
    String? password,
  }) async {
    final supabase = Supabase.instance.client;
    return supabase.auth.signIn(
      email: email.trim(),
      password: password?.trim(),
      options: const AuthOptions(
        redirectTo: kIsWeb
            ? 'http://152.69.226.149:8000/'
            : 'io.supabase.flutterquickstart://login-callback',
      ),
    );
  }

  Future<bool> loginWithGoogle() async {
    final supabase = Supabase.instance.client;
    return supabase.auth.signInWithProvider(
      Provider.google,
      options: const AuthOptions(
        redirectTo: kIsWeb
            ? 'http://152.69.226.149:8000/'
            : 'io.supabase.flutterquickstart://login-callback',
      ),
    );
  }

  Future<void> loginWithFacebook() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithProvider(
      Provider.facebook,
      options: const AuthOptions(
        redirectTo: kIsWeb
            ? 'http://152.69.226.149:8000/'
            : 'io.supabase.flutterquickstart://login-callback',
      ),
    );
  }

  Future<GotrueSessionResponse> register({
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;

    return supabase.auth.signUp(
      email.trim(),
      password.trim(),
      options: const AuthOptions(
        redirectTo: kIsWeb
            ? 'http://152.69.226.149:8000/'
            : 'io.supabase.flutterquickstart://login-callback',
      ),
    );
  }

  Future<GotrueJsonResponse> requestRecoveryPassword(
      {required String email}) async {
    final supabase = Supabase.instance.client;
    return supabase.auth.api.resetPasswordForEmail(
      email.trim(),
      options: const AuthOptions(
        redirectTo: kIsWeb
            ? 'http://152.69.226.149:8000/'
            : 'io.supabase.flutterquickstart://login-callback',
      ),
    );
  }

  Future<GotrueUserResponse> updatePassword({required String password}) async {
    final supabase = Supabase.instance.client;
    return supabase.auth.update(UserAttributes(password: password));
  }
}
