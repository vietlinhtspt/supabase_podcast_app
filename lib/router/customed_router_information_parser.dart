import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';
import '../ui/auth/recovery_password_screen.dart';
import '../ui/auth/registration_screen.dart';
import '../ui/splash/splash_screen.dart';
import '../ui/unknown/unknown_screen.dart';
import 'customed_router_configuration.dart';

class CustomedRouteInformationParser
    extends RouteInformationParser<CustomedRouterConfiguration> {
  @override
  Future<CustomedRouterConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    // debugPrint('parseRouteInformation: $uri');
    if (uri.pathSegments.isEmpty) {
      return RouterConfigurationHome();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == RegistrationScreen.ROUTE_NAME) {
        return RouterConfigurationSigningUp();
      } else if (first == RecoveryPasswordScreen.ROUTE_NAME) {
        return RouterConfigurationRecoveringPassword();
      } else if (first == LoginScreen.ROUTE_NAME) {
        return RouterConfigurationLogingIn();
      } else if (first == SplashScreen.ROUTE_NAME) {
        return RouterConfigurationSpashing();
      } else {
        return RouterConfigurationUnknown();
      }
    } else {
      return RouterConfigurationUnknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(
    CustomedRouterConfiguration configuration,
  ) {
    // debugPrint(
    //     '''restoreRouteInformation: ${configuration.runtimeType} \n${configuration.toString()}''');
    RouteInformation? restoredRouteInformation;

    if (configuration is RouterConfigurationSpashing) {
      restoredRouteInformation = RouteInformation(
        location: SplashScreen.ROUTE_NAME,
      );
    } else if (configuration is RouterConfigurationHome) {
      restoredRouteInformation = const RouteInformation(location: '');
    } else if (configuration is RouterConfigurationSigningUp) {
      restoredRouteInformation = RouteInformation(
        location: RegistrationScreen.ROUTE_NAME,
      );
    } else if (configuration is RouterConfigurationRecoveringPassword) {
      restoredRouteInformation = RouteInformation(
        location: RecoveryPasswordScreen.ROUTE_NAME,
      );
    } else if (configuration is RouterConfigurationLogingIn) {
      restoredRouteInformation = RouteInformation(
        location: LoginScreen.ROUTE_NAME,
      );
    } else {
      restoredRouteInformation = RouteInformation(
        location: UnknownScreen.ROUTE_NAME,
      );
    }

    // debugPrint(
    //     '''restoreRouteInformation: ${restoredRouteInformation.location}''');
    return restoredRouteInformation;
  }
}
