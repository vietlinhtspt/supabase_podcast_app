// ignore_for_file: lines_longer_than_80_chars

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/components.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_info_provider.dart';
import 'selecting_language_screen.dart';
import 'setting_new_name_screen.dart';
import 'setting_new_password_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 10),
            child: Image.asset(
              'assets/logos/melior_rounded_logo.png',
              width: 120,
              height: 120,
            ),
          ),
          Image.asset(
            'assets/logos/melior_text_logo.png',
            height: 50,
          ),
          const SizedBox(
            height: 40,
          ),
          SettingItemWidget(
            title: context.watch<UserInfoProvider>().userInfo?.name ?? '',
            iconPath: 'assets/icons/accounts/ic_editting.svg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingNewNameScreen()),
            ),
          ),
          SettingItemWidget(
            title: 'setting_screen.settting_theme_mode'.tr(),
            iconPath:
                context.watch<UserInfoProvider>().userInfo?.isDarkMode == false
                    ? 'assets/icons/accounts/ic_light_mode.svg'
                    : 'assets/icons/accounts/ic_dark_mode.svg',
            onTap: () =>
                context.read<UserInfoProvider>().changeThemeMode(context),
          ),
          SettingItemWidget(
            title: 'setting_screen.settting_changing_password'.tr(),
            iconPath: 'assets/icons/accounts/ic_key.svg',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingNewPasswordScreen()),
            ),
          ),
          SettingItemWidget(
            title: 'setting_screen.settting_language'.tr(),
            iconPath: 'assets/icons/accounts/ic_language.svg',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SelectingLanguageScreen())),
          ),
          SettingItemWidget(
            title: 'setting_screen.settting_log_out'.tr(),
            iconPath: 'assets/icons/accounts/ic_logout.svg',
            onTap: () => context.read<AuthProvider>().logout(context),
          ),
        ],
      ),
    );
  }
}
