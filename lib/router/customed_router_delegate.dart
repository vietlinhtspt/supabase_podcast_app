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

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  CustomedRouterDelegate() : _navigatorKey = GlobalKey<NavigatorState>();

  CustomedRouterConfiguration _currentRouterConfig = RouterConfigurationHome();

  void goSignUpScreen() {
    _currentRouterConfig = RouterConfigurationSigningUp();
    notifyListeners();
  }

  void backToLoginScreen() {
    _currentRouterConfig = RouterConfigurationLogingIn();
    notifyListeners();
  }

  void goRecoveryPassword() {
    _currentRouterConfig = RouterConfigurationRecoveringPassword();
    notifyListeners();
  }

  @override
  CustomedRouterConfiguration get currentConfiguration => _currentRouterConfig;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      List<Page> stack;
      // debugPrint(
      //     'Build currentConfiguration: ${currentConfiguration.runtimeType}');
      _currentRouterConfig = currentConfiguration.copyWith(
        isLoggedIn: provider.isLogedIn,
      );

      // debugPrint(
      //     'Build currentConfiguration: ${currentConfiguration.runtimeType}');

      if (currentConfiguration is RouterConfigurationSpashing) {
        stack = _splashStack;
      } else if (currentConfiguration is RouterConfigurationHome) {
        stack = _homeStack;
      } else if (currentConfiguration is RouterConfigurationSigningUp) {
        stack = _signUpStack;
      } else if (currentConfiguration
          is RouterConfigurationRecoveringPassword) {
        stack = _recoveryPasswordStack;
      } else if (currentConfiguration is RouterConfigurationLogingIn) {
        stack = _loginStack;
      } else {
        stack = _unknownStack;
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
          valueKey: SplashScreen.ROUTE_NAME,
        ),
      ];

  List<Page> get _loginStack => [
        CustomedRouterPage(
          child: const LoginScreen(),
          valueKey: LoginScreen.ROUTE_NAME,
        ),
      ];

  List<Page> get _homeStack {
    return [
      CustomedRouterPage(
        child: const NavigationScreen(),
        valueKey: ''.toLowerCase(),
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
          valueKey: UnknownScreen.ROUTE_NAME,
        ),
      ];

  @override
  Future<void> setNewRoutePath(configuration) async {
    // debugPrint('setNewRoutePath: ${configuration.toString()}');
    _currentRouterConfig = configuration;
  }
}
