import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  final SharedPreferences preference;

  AuthRepository(this.preference);

  Future<bool> isUserLoggedIn() async =>
      Future.delayed(const Duration(seconds: 2)).then((value) {
        return preference.getBool(_AUTH_KEY) ?? false;
      });

  Future<bool> updateLoginStatus(bool loggedIn) =>
      Future.delayed(const Duration(seconds: 2)).then((value) {
        return preference.setBool(_AUTH_KEY, loggedIn);
      });

  Future<void> logout() async {
    final supabase = Supabase.instance.client;

    await supabase.auth.signOut();
  }

  Future<void> loginWithEmail({
    required String email,
    String? password,
  }) async {
    final supabase = Supabase.instance.client;

    await supabase.auth.signIn(
      email: email.trim(),
      password: password?.trim(),
    );
  }

  Future<void> loginWithGoogle() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithProvider(
      Provider.google,
    );
  }

  Future<void> loginWithFacebook() async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signInWithProvider(
      Provider.facebook,
    );
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final supabase = Supabase.instance.client;

    var registerStatus = false;

    final response = await supabase.auth.signUp(
      email.trim(),
      password.trim(),
      options: AuthOptions(
          redirectTo:
              kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback'),
    );

    if (response.statusCode == 200) {
      registerStatus = true;
      print('Create account success');
    }

    return registerStatus;
  }

  Future<void> recoveryPassword({required String email}) async {
    final supabase = Supabase.instance.client;

    final response =
        await supabase.auth.api.resetPasswordForEmail(email.trim());
    print(response.data);
  }
}
