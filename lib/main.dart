import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_color/flutter_color.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/providers.dart';
import 'repositories/audio_player_handle.dart';
import 'router/router.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  late AudioHandler _audioHandler;

  await Future.wait([
    EasyLocalization.ensureInitialized(),
    Supabase.initialize(
      url: 'https://vcdtzzxxfqnbehzlyfne.supabase.co',
      anonKey: '''
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjZHR6enh4ZnFuYmVoemx5Zm5lIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjAzMjE2MzYsImV4cCI6MTk3NTg5NzYzNn0.q1aPBQBjV5B4fI9ejYa-ygcnw76mCrJdogDwQb3oY-8''',
      debug: true,
    ),
    AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
        androidNotificationChannelName: 'Audio playback',
        androidNotificationOngoing: true,
      ),
    ).then((value) => _audioHandler = value)
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MyApp(key: MyApp.GLOBAL_KEY, audioHandler: _audioHandler),
      useOnlyLangCode: true,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required AudioHandler audioHandler})
      : _audioHandler = audioHandler,
        super(key: key);

  final AudioHandler _audioHandler;
  static final GLOBAL_KEY = GlobalKey<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CustomedRouterDelegate delegate;
  late CustomedRouteInformationParser parser;
  String? currentLanguage;

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
        ),
        ChangeNotifierProvider<UserInfoProvider>(
          create: (_) => UserInfoProvider(),
        ),
        ChangeNotifierProvider<PodcastProvider>(
          create: (_) => PodcastProvider(),
        ),
        ChangeNotifierProvider<AudioProvider>(
          create: (_) => AudioProvider(audioHandler: widget._audioHandler),
        ),
      ],
      child:
          Consumer<UserInfoProvider>(builder: (context, userProvider, child) {
        if (currentLanguage != null &&
            userProvider.userInfo?.language != null &&
            currentLanguage != userProvider.userInfo?.language) {
          context.setLocale(Locale(userProvider.userInfo!.language!));
        }

        currentLanguage = userProvider.userInfo?.language;
        return MaterialApp.router(
          routerDelegate: delegate,
          routeInformationParser: parser,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
            fontFamily: GoogleFonts.nunito().fontFamily,
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
            fontFamily: GoogleFonts.nunito().fontFamily,
          ),
          themeMode: userProvider.userInfo?.isDarkMode ?? false
              ? ThemeMode.dark
              : ThemeMode.light,
        );
      }),
    );
  }
}
