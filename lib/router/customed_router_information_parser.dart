import 'package:flutter/material.dart';

import '../ui/auth/registration_screen.dart';
import 'customed_router_configuration.dart';

class CustomedRouteInformationParser
    extends RouteInformationParser<CustomedRouterConfiguration> {
  @override
  Future<CustomedRouterConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? '');
    // debugPrint('parseRouteInformation: $uri');
    if (uri.pathSegments.isEmpty) {
      return CustomedRouterConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == RegistrationScreen.ROUTE_NAME) {
        return CustomedRouterConfiguration.signUp();
      } else {
        return CustomedRouterConfiguration.home();
      }
    } else {
      return CustomedRouterConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(
      CustomedRouterConfiguration configuration) {
    // debugPrint('restoreRouteInformation: ${configuration.toString()}');
    if (configuration.isUnknown) {
      return const RouteInformation(location: 'unknown');
    } else if (configuration.isSplashPage) {
      return null;
    } else if (configuration.isSigningUp) {
      return RouteInformation(location: RegistrationScreen.ROUTE_NAME);
    } else if (configuration.isLoginPage || configuration.isHomePage) {
      return const RouteInformation(location: '');
    } else {
      return null;
    }
  }
}
