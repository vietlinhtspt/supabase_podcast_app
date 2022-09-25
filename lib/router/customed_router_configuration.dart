abstract class CustomedRouterConfiguration {
  // Step to add state:
  // 1. Add variable
  // 2. Add Named constructor
  // 3. Add hash code
  late bool _isLoggedIn;

  @override
  String toString() {
    return '''
  ---
  runtimeType: ${runtimeType}
  _isLoggedIn: ${_isLoggedIn.toString()}
  ---''';
  }

  CustomedRouterConfiguration copyWith({
    bool? isLoggedIn,
  });
}

class RouterConfigurationSpashing extends CustomedRouterConfiguration {
  RouterConfigurationSpashing({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationSpashing copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationSpashing(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}

class RouterConfigurationLogingIn extends CustomedRouterConfiguration {
  RouterConfigurationLogingIn({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationLogingIn copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationLogingIn(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}

class RouterConfigurationSigningUp extends CustomedRouterConfiguration {
  RouterConfigurationSigningUp({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationSigningUp copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationSigningUp(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}

class RouterConfigurationRecoveringPassword
    extends CustomedRouterConfiguration {
  RouterConfigurationRecoveringPassword({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationRecoveringPassword copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationRecoveringPassword(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}

class RouterConfigurationHome extends CustomedRouterConfiguration {
  RouterConfigurationHome({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationHome copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationHome(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}

class RouterConfigurationUnknown extends CustomedRouterConfiguration {
  RouterConfigurationUnknown({
    bool isLoggedIn = false,
  }) {
    _isLoggedIn = isLoggedIn;
  }

  @override
  RouterConfigurationUnknown copyWith({
    bool? isLoggedIn,
  }) {
    {
      return RouterConfigurationUnknown(
        isLoggedIn: isLoggedIn ?? false,
      );
    }
  }
}
