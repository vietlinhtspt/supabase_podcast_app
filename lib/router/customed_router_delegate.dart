import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../ui/auth/login_screen.dart';
import '../ui/auth/recovery_password_screen.dart';
import '../ui/auth/registration_screen.dart';
import '../ui/navigation_screen/navigation_screen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/unknown/unknown_screen.dart';
import 'customed_router_configuration.dart';
import 'customed_router_page.dart';

class CustomedRouterDelegate extends RouterDelegate<CustomedRouterConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;

  bool? _show404;
  bool? _loggedIn;
  bool? _isSigningUp;
  bool? _recoveringPassword;
  bool? _spashing;

  void goSignUpScreen() {
    _show404 = false;
    _loggedIn = false;
    _isSigningUp = true;
    _recoveringPassword = false;
    _spashing = false;
    notifyListeners();
  }

  void backToLoginScreen() {
    _show404 = false;
    _loggedIn = false;
    _isSigningUp = false;
    _recoveringPassword = false;
    _spashing = false;
    notifyListeners();
  }

  void goRecoveryPassword() {
    _show404 = false;
    _loggedIn = false;
    _isSigningUp = false;
    _recoveringPassword = true;
    _spashing = false;
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  CustomedRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  @override
  CustomedRouterConfiguration? get currentConfiguration {
    if (_isSigningUp == true) {
      return CustomedRouterConfiguration.signUp();
    } else if (_show404 == true) {
      return CustomedRouterConfiguration.unknown();
    } else if (_spashing == true) {
      return CustomedRouterConfiguration.splash();
    } else if (_recoveringPassword == true) {
      return CustomedRouterConfiguration.recoveringPassword();
    } else if (_loggedIn == false && _show404 == false) {
      return CustomedRouterConfiguration.login();
    } else if (_loggedIn == true) {
      return CustomedRouterConfiguration.home();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      List<Page> stack;
      _loggedIn = provider.isLogedIn;
      if (provider.isSpashing) {
        stack = _splashStack;
      } else if (provider.isLogedIn) {
        stack = _loggedInStack;
      } else if (_show404 == true) {
        stack = _unknownStack;
      } else if (_isSigningUp == true) {
        stack = _signUpStack;
      } else if (_recoveringPassword == true) {
        stack = _recoveryPasswordStack;
      } else {
        stack = _loggedOutStack;
      }
      return Navigator(
        key: navigatorKey,
        pages: stack,
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
      );
    });
  }

  List<Page> get _splashStack => [
        CustomedRouterPage(
          child: const SplashScreen(),
          valueKey: 'splashscreen',
        ),
      ];

  List<Page> get _loggedOutStack => [
        CustomedRouterPage(
          child: const LoginScreen(),
          valueKey: 'login',
        ),
      ];

  List<Page> get _loggedInStack {
    return [
      CustomedRouterPage(
        child: const NavigationScreen(),
        valueKey: 'NavigationScreen'.toLowerCase(),
      )
    ];
  }

  List<Page> get _signUpStack {
    return [
      CustomedRouterPage(
        child: const RegistrationScreen(),
        valueKey: RegistrationScreen.ROUTE_NAME,
      )
    ];
  }

  List<Page> get _recoveryPasswordStack {
    return [
      CustomedRouterPage(
        child: const RecoveryPasswordScreen(),
        valueKey: RecoveryPasswordScreen.ROUTE_NAME,
      )
    ];
  }

  List<Page> get _unknownStack => [
        CustomedRouterPage(
          child: const UnknownScreen(),
          valueKey: 'unknown',
        ),
      ];

  @override
  Future<void> setNewRoutePath(configuration) async {
    // debugPrint('setNewRoutePath: ${configuration.toString()}');
    if (configuration.isUnknown) {
      _show404 = true;
      _isSigningUp = false;
    } else if (configuration.isSigningUp) {
      _show404 = false;
      _isSigningUp = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      _show404 = false;
      _isSigningUp = false;
    } else {
      debugPrint(' Could not set new route');
    }
  }
}
