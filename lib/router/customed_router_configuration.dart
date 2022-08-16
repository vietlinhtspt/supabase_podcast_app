class CustomedRouterConfiguration {
  final bool? unknown;
  final bool? loggedIn;
  final bool? signingUp;
  final bool? recoveringPassword;

  @override
  String toString() {
    return '''
---
unknown: ${unknown.toString()}
loggedIn: ${loggedIn.toString()}
signingUp: ${isSigningUp.toString()}
recoveringPassword: ${recoveringPassword.toString()}
---''';
  }

  CustomedRouterConfiguration.splash()
      : unknown = false,
        loggedIn = null,
        signingUp = false,
        recoveringPassword = false;

  CustomedRouterConfiguration.login()
      : unknown = false,
        loggedIn = false,
        signingUp = false,
        recoveringPassword = false;

  CustomedRouterConfiguration.signUp()
      : unknown = false,
        loggedIn = false,
        signingUp = true,
        recoveringPassword = false;

  CustomedRouterConfiguration.home()
      : unknown = false,
        loggedIn = true,
        signingUp = false,
        recoveringPassword = false;

  CustomedRouterConfiguration.unknown()
      : unknown = true,
        loggedIn = null,
        signingUp = false,
        recoveringPassword = false;

  CustomedRouterConfiguration.recoveringPassword()
      : unknown = true,
        loggedIn = null,
        signingUp = false,
        recoveringPassword = false;

  bool get isUnknown => unknown == true;
  bool get isHomePage => unknown == false && loggedIn == true;
  bool get isLoginPage => unknown == false && loggedIn == false;
  bool get isSplashPage => unknown == false && loggedIn == null;
  bool get isSigningUp => unknown == false && signingUp == true;
  bool get isRecoveringPassword =>
      unknown == false && recoveringPassword == true;
}
