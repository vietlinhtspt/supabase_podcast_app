import 'package:flutter/material.dart';

class CustomedRouterPage extends Page {
  final String valueKey;
  final Widget child;

  CustomedRouterPage({
    required this.child,
    required this.valueKey,
  }) : super(key: ValueKey(valueKey));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => child,
    );
  }
}
