import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_color/flutter_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/foundation.dart';

import 'providers/providers.dart';
import 'router/router.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (defaultTargetPlatform == TargetPlatform.android) {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId('adaeae8b-36b0-4fd6-9370-bce41d702536');

    // The promptForPushNotificationsWithUserResponse function will show the iOS
    // push notification prompt. We recommend removing the following code and
    // instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      debugPrint('Accepted permission: $accepted');
    }); // Android-specific code
  }

  await Supabase.initialize(
    url: 'https://vcdtzzxxfqnbehzlyfne.supabase.co',
    anonKey: '''
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjZHR6enh4ZnFuYmVoemx5Zm5lIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjAzMjE2MzYsImV4cCI6MTk3NTg5NzYzNn0.q1aPBQBjV5B4fI9ejYa-ygcnw76mCrJdogDwQb3oY-8''',
    debug: true,
  );

  runApp(MyApp(key: MyApp.GLOBAL_KEY));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GLOBAL_KEY = GlobalKey<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CustomedRouterDelegate delegate;
  late CustomedRouteInformationParser parser;

  @override
  void initState() {
    delegate = CustomedRouterDelegate();
    parser = CustomedRouteInformationParser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<CustomedRouterDelegate>(
          create: (_) => delegate,
        ),
        ChangeNotifierProvider<SelectingFriendsProvider>(
          create: (_) => SelectingFriendsProvider(),
        )
      ],
      child: MaterialApp.router(
        routerDelegate: delegate,
        routeInformationParser: parser,
        backButtonDispatcher: RootBackButtonDispatcher(),
        theme: FlexThemeData.light(
          scheme: FlexScheme.bigStone,
          primary: const Color(0xffC93155),
          secondary: const Color(0xffF3542C),
          onPrimaryContainer: const Color(0xff333333),
          primaryContainer: Colors.white,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 20,
          appBarOpacity: 0.95,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            blendOnColors: false,
            navigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
            navigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
        ),
        darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.bigStone,
          primary: const Color(0xffC93155).mix(Colors.black, 0.1),
          secondary: const Color(0xffF3542C).mix(Colors.black, 0.1),
          onPrimaryContainer: const Color(0xffcccccc).mix(Colors.black, 0.1),
          primaryContainer: Colors.black,
          surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
          blendLevel: 15,
          appBarStyle: FlexAppBarStyle.background,
          appBarOpacity: 0.90,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 30,
            navigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
            navigationBarSelectedIconSchemeColor: SchemeColor.secondary,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
