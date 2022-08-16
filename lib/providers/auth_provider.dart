import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;
  bool isLogedIn = false;
  bool isSpashing = false;

  AuthProvider({AuthRepository? authRepository}) {
    if (authRepository != null) {
      this.authRepository = authRepository;
    } else {
      SharedPreferences.getInstance().then((preference) {
        this.authRepository = AuthRepository(preference);
      });
    }

    Supabase.instance.client.auth.onAuthStateChange((event, session) {
      switch (event) {
        case AuthChangeEvent.signedIn:
          isLogedIn = true;
          authRepository?.updateLoginStatus(isLogedIn);
          notifyListeners();
          break;
        case AuthChangeEvent.signedOut:
          isLogedIn = false;
          authRepository?.updateLoginStatus(isLogedIn);
          notifyListeners();
          break;
        default:
      }
    });

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      isLogedIn = true;
      authRepository?.updateLoginStatus(true);
    }
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    isSpashing = true;
    notifyListeners();
    await authRepository.loginWithEmail(email: email, password: password);
    isSpashing = false;
    notifyListeners();
  }

  Future<void> loginWithMagicLink({
    required String email,
  }) async {
    isSpashing = true;
    notifyListeners();
    await authRepository.loginWithEmail(email: email);
    isSpashing = false;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    isSpashing = true;
    notifyListeners();
    await authRepository.loginWithGoogle();
    isSpashing = false;
    notifyListeners();
  }

  Future<void> loginWithFacebook() async {
    isSpashing = true;
    notifyListeners();
    await authRepository.loginWithFacebook();
    isSpashing = false;
    notifyListeners();
  }

  Future<void> logout() async {
    isSpashing = true;
    notifyListeners();
    await authRepository.logout();
    isSpashing = false;
    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    final status = await authRepository.register(
      email: email,
      password: password,
    );
    return status;
  }

  Future<void> recoveryPassword({
    required String email,
  }) async {
    await authRepository.recoveryPassword(
      email: email,
    );
  }
}
