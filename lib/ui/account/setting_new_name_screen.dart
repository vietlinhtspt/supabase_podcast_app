import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info_provider.dart';
import '../../shared/shared.dart';

class SettingNewNameScreen extends StatefulWidget {
  const SettingNewNameScreen({Key? key}) : super(key: key);

  @override
  State<SettingNewNameScreen> createState() => _SettingNewNameScreenState();
}

class _SettingNewNameScreenState extends State<SettingNewNameScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final isMaximunHeight = MediaQuery.of(context).size.width >= 500;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor:
          Theme.of(context).navigationBarTheme.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: !isDarkMode ? Brightness.light : Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 350,
                minHeight: 500,
                maxWidth: 500,
                maxHeight: isMaximunHeight ? 700 : double.infinity,
              ),
              child: Container(
                height:
                    isMaximunHeight ? null : MediaQuery.of(context).size.height,
                decoration: isMaximunHeight
                    ? BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Stack(children: [
                          Positioned(
                            left: -20,
                            child: TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: SvgPicture.asset(
                                'assets/icons/accounts/ic_back.svg',
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'setting_screen.change_name_now'.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    M3TextField(
                      controller: _passwordController,
                      labelText: 'setting_screen.enter_your_name'.tr(),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: M3LockedButton(
                        onPressed: () async {
                          if (_passwordController.text.trim().isEmpty) {
                            await showM3Popup(
                              context,
                              title: 'popup.warning'.tr(),
                              descriptions: 'popup.not_entered_your_name'.tr(),
                            );
                          } else {
                            await context
                                .read<UserInfoProvider>()
                                .changeName(
                                  context,
                                  name: _passwordController.text,
                                )
                                .then((value) async => value == true
                                    ? await showM3Popup(
                                        context,
                                        title: 'popup.success'.tr(),
                                        descriptions:
                                            'popup.update_password_success'
                                                .tr(),
                                      ).then((value) => Navigator.pop(context))
                                    : null);
                          }
                        },
                        title: 'setting_screen.update'.tr(),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
