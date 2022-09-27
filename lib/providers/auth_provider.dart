import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../repositories/auth_repository.dart';
import '../repositories/supabase_data_repository.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;
  bool isLogedIn = false;
  bool isSpashing = false;
  bool isRecoveringPassword = false;
  AuthChangeEvent? lastEvent;

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
          if (lastEvent != AuthChangeEvent.signedIn) {
            if (!isSpashing) {
              isSpashing = true;
              notifyListeners();
            }
          }

          break;
        case AuthChangeEvent.signedOut:
          isLogedIn = false;
          notifyListeners();
          break;
        case AuthChangeEvent.passwordRecovery:
          isRecoveringPassword = true;
          notifyListeners();
          break;
        default:
      }
      lastEvent = event;
    });

    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      isSpashing = true;
    }

    notifyListeners();
  }

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    await supabaseCallAPI(context, function: () async {
      await authRepository.loginWithEmail(
        email: email,
        password: password,
      );
    });
  }

  Future<bool> loginWithMagicLink(
    BuildContext context, {
    required String email,
  }) async {
    var status = false;
    await supabaseCallAPI(context, function: () async {
      await authRepository.loginWithEmail(email: email);
      status = true;
    });
    return status;
  }

  Future<void> loginWithGoogle(
    BuildContext context,
  ) async {
    await supabaseCallAPI(context, function: () async {
      await authRepository.loginWithGoogle();
    });
  }

  Future<void> loginWithFacebook(
    BuildContext context,
  ) async {
    await supabaseCallAPI(context, function: () async {
      await authRepository.loginWithFacebook();
    });
  }

  Future<void> logout(
    BuildContext context,
  ) async {
    await supabaseCallAPI(context, function: () async {
      await authRepository.logout();
    });
  }

  Future<bool> register(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    var status = false;
    await supabaseCallAPI(context, function: () async {
      final response = await authRepository.register(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        status = true;
      }
    });
    return status;
  }

  Future<bool> requestRecoveryPassword(
    BuildContext context, {
    required String email,
  }) async {
    var status = false;
    await supabaseCallAPI(context, function: () async {
      final response = await authRepository.requestRecoveryPassword(
        email: email,
      );
      if (response.statusCode == 200) {
        status = true;
      }
    });
    return status;
  }

  Future<bool> recoveryPassword(
    BuildContext context, {
    required String password,
  }) async {
    var status = false;
    await supabaseCallAPI(context, function: () async {
      final response = await authRepository.updatePassword(
        password: password,
      );

      isRecoveringPassword = false;
      notifyListeners();
      if (response.statusCode == 200) {
        status = true;
      }
    });
    return status;
  }

  void completeInitData() {
    isSpashing = false;
    isLogedIn = true;
    notifyListeners();
  }
}
