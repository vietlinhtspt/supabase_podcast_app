import 'package:audio_service/audio_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../shared/shared.dart';
import '../account/account_screen.dart';
import '../auth/setting_new_password_screen.dart';
import '../home/entering_name_screen/entering_name_screen.dart';
import '../home/home_screen.dart';
import '../library/library_screen.dart';
import '../player/maximum_player_widget.dart';
import '../player/minimum_player_widget.dart';
import '../searching/searching_screen.dart';
import 'components/m3_navbar_item_widget.dart';
import 'components/qr_info_navigation_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final UPDATE_HISTORY_PERIOD = 3;
  int screenIndex = 0;
  int navIndex = 0;
  ResponsiveType? currentScreenType;
  bool isUpdatingHistory = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AudioService.position.asBroadcastStream().listen((event) {
        final indexOfCurrentPodcast = context
            .read<PodcastProvider>()
            .podcast
            .indexWhere((element) =>
                element.id ==
                context.read<AudioProvider>().currentPodcastModel?.id);

        if (indexOfCurrentPodcast != -1) {
          final currentPodcast =
              context.read<PodcastProvider>().podcast[indexOfCurrentPodcast];
          context.read<PodcastProvider>().updateHistoryLocal(context,
              historyDetail: currentPodcast.historyDetail?.copyWith(
                createdAt: DateTime.now().toString() + '+00:00',
                listened: event.inSeconds,
              ));
        }

        if (indexOfCurrentPodcast != -1 &&
            event.inSeconds > UPDATE_HISTORY_PERIOD) {
          final currentPodcast =
              context.read<PodcastProvider>().podcast[indexOfCurrentPodcast];
          final isNeedUpdate =
              (event.inSeconds - (currentPodcast.historyDetail?.listened ?? 0))
                      .abs() >
                  UPDATE_HISTORY_PERIOD;
          if (isNeedUpdate && !isUpdatingHistory) {
            isUpdatingHistory = true;
            context.read<PodcastProvider>().podcast[indexOfCurrentPodcast] =
                currentPodcast.copyWith(
              historyDetail: currentPodcast.historyDetail?.copyWith(
                createdAt: DateTime.now().toString() + '+00:00',
                listened: event.inSeconds,
              ),
            );
            context.read<PodcastProvider>().notifyListeners();
            context
                .read<PodcastProvider>()
                .updateHistory(
                  context,
                  historyDetail: currentPodcast.historyDetail!,
                )
                .then((value) {
              if (value == true) {
                context.read<PodcastProvider>().podcast[indexOfCurrentPodcast] =
                    context
                        .read<PodcastProvider>()
                        .podcast[indexOfCurrentPodcast]
                        .copyWith(
                          historyDetail: context
                              .read<PodcastProvider>()
                              .podcast[indexOfCurrentPodcast]
                              .historyDetail
                              ?.copyWith(id: -1),
                        );
                context.read<PodcastProvider>().notifyListeners();
              }

              isUpdatingHistory = false;
            });
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.primaryContainer,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: !isDarkMode ? Brightness.light : Brightness.dark,
    ));

    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = Responsive.isMobile(context);

      final newScreenType = Responsive.checkScreenType(context);
      if (currentScreenType != null && newScreenType != currentScreenType) {
        _changeScreenIndex(screenIndex);
      }
      currentScreenType = newScreenType;

      // final isTablet = Responsive.isTablet(context);
      // final isDesktop = Responsive.isDesktop(context);
      // debugPrint('=========');
      // debugPrint('isMobile: $isMobile');
      // debugPrint('isTablet: $isTablet');
      // debugPrint('isDesktop: $isDesktop');
      // debugPrint('width: ${MediaQuery.of(context).size.width}');
      // debugPrint('height: ${MediaQuery.of(context).size.height}');
      // debugPrint('=========');

      final isVertical = !isMobile;

      return Scaffold(
        body: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Stack(
            children: [
              AnimatedPositioned(
                top: 0,
                left: isVertical ? 80 : 0,
                right: 0,
                bottom: 0,
                duration: const Duration(milliseconds: 500),
                child: [
                  const HomeScreen(),
                  const SearchingScreen(),
                  const LibraryScreen(),
                  const AccountScreen()
                ][screenIndex],
              ),
              AnimatedPositioned(
                top: isVertical
                    ? 0
                    : MediaQuery.of(context).size.height -
                        QRInfoNavigationBar.HEIGHT,
                bottom: 0,
                left: 0,
                right: isVertical ? null : 0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: QRInfoNavigationBar(
                  screenIndex: navIndex,
                  isVertical: isVertical,
                  centerItemText: '',
                  notchedShape: const CircularNotchedRectangle(),
                  onTabSelected: _changeScreenIndex,
                  items: [
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_home@512x.png',
                      iconPathSelected: 'assets/icons/tabbar/ic_home@512x.png',
                      text: 'home'.tr(),
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_searching@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_searching@512x.png',
                      text: 'explore'.tr(),
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_library@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_library@512x.png',
                      text: 'library'.tr(),
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_setting@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_setting@512x.png',
                      text: 'setting'.tr(),
                    ),
                  ],
                ),
              ),
              if (context.watch<AudioProvider>().currentPodcastModel != null)
                Positioned(
                  top: MediaQuery.of(context).size.height -
                      (Responsive.isMobile(context) ? 75 : 110) -
                      (isVertical ? 0 : QRInfoNavigationBar.HEIGHT),
                  left: 0,
                  right: 0,
                  child: const MinimumPlayerWidget(),
                ),
              if (context.watch<AudioProvider>().currentPodcastModel != null &&
                  isMobile)
                const MaximumPlayerWidget(),
              if (context.watch<UserInfoProvider>().userInfo != null &&
                  context.watch<UserInfoProvider>().userInfo?.email == null)
                const Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: EnteringNameScreen(),
                ),
              if (context.watch<AuthProvider>().isRecoveringPassword)
                const Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SettingNewPasswordScreen(),
                ),
            ],
          ),
        ),
      );
    });
  }

  int _changeScreenIndex(int newIndex) {
    navIndex = newIndex;
    screenIndex = newIndex;

    if (mounted) setState(() {});
    return screenIndex;
  }
}
