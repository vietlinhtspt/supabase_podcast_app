import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_info_provider.dart';
import '../../shared/shared.dart';
import '../account/account_screen.dart';
import '../auth/setting_new_password_screen.dart';
import '../entering_name_screen/entering_name_screen.dart';
import '../friends/friends_screen.dart';
import '../home/home_screen.dart';
import '../notifications/notifications_screen.dart';
import 'components/m3_navbar_item_widget.dart';
import 'components/qr_info_navigation_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int screenIndex = 0;
  int navIndex = 0;
  ResponsiveType? currentScreenType;

  @override
  void initState() {
    super.initState();
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
                  const FriendsScreen(),
                  const NotificationsScreen(),
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
                      text: 'Home',
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_searching@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_searching@512x.png',
                      text: 'Explore',
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_library@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_library@512x.png',
                      text: 'Libary',
                    ),
                    QRInfoNavigationBarItem(
                      iconPath: 'assets/icons/tabbar/ic_setting@512x.png',
                      iconPathSelected:
                          'assets/icons/tabbar/ic_setting@512x.png',
                      text: 'Setting',
                    ),
                  ],
                ),
              ),
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
