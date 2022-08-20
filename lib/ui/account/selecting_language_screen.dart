import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info_provider.dart';
import 'components/language_item_widget.dart';

class SelectingLanguageScreen extends StatelessWidget {
  const SelectingLanguageScreen({Key? key}) : super(key: key);

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
                        'language.title'.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    LanguageItemWidget(
                      title: 'language.english'.tr(),
                      onTap: () =>
                          context.read<UserInfoProvider>().changeLanguage(
                                context,
                                newLanguage: 'en',
                              ),
                      isSelected: context
                              .watch<UserInfoProvider>()
                              .userInfo
                              ?.language ==
                          'en',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    LanguageItemWidget(
                      title: 'language.vietnamese'.tr(),
                      onTap: () =>
                          context.read<UserInfoProvider>().changeLanguage(
                                context,
                                newLanguage: 'vi',
                              ),
                      isSelected: context
                              .watch<UserInfoProvider>()
                              .userInfo
                              ?.language ==
                          'vi',
                    ),
                    const SizedBox(
                      height: 24,
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
