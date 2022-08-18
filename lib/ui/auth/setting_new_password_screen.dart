import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../shared/shared.dart';
import '../popups/m3_popup.dart';

class SettingNewPasswordScreen extends StatefulWidget {
  const SettingNewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SettingNewPasswordScreen> createState() =>
      _SettingNewPasswordScreenState();
}

class _SettingNewPasswordScreenState extends State<SettingNewPasswordScreen> {
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
                      child: Text(
                        'Cập nhật mật khẩu',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 45,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '''
Nhập mật khẩu mới của bạn nữa là xong rồi''',
                        style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    M3TextField(
                      controller: _passwordController,
                      labelText: 'Mật khẩu',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    M3TextField(
                      controller: _confirmPasswordController,
                      labelText: 'Nhập lại mật khẩu',
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: M3LockedButton(
                        onPressed: () async {
                          if (_passwordController.text.length < 6) {
                            await showM3Popup(
                              context,
                              title: 'Cảnh báo',
                              descriptions: '''
Độ dài tối thiểu của mật khẩu là 6 ký tự''',
                            );
                          } else if (_passwordController.text.trim() !=
                              _confirmPasswordController.text.trim()) {
                            await showM3Popup(
                              context,
                              title: 'Cảnh báo',
                              descriptions: '''
Mật khẩu và mật khẩu xác nhận không trùng nhau''',
                            );
                          } else {
                            await context
                                .read<AuthProvider>()
                                .recoveryPassword(
                                  context,
                                  password: _passwordController.text,
                                )
                                .then((value) async => value == true
                                    ? await showM3Popup(
                                        context,
                                        title: 'Thành công',
                                        descriptions: '''
Cập nhật mật khẩu thành công''',
                                      )
                                    : null);
                          }
                        },
                        title: 'Cập nhật',
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
