import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../router/customed_router_delegate.dart';
import '../../shared/shared.dart';
import '../popups/m3_popup.dart';
import 'components/authentication_platform_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

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

    final isMaximunHeight = MediaQuery.of(context).size.width >= 500;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 350,
                minHeight: 350,
                maxWidth: 500,
                maxHeight: isMaximunHeight ? 600 : double.infinity,
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
                      child: SvgPicture.asset(
                        'assets/icons/home/hello_custom.svg',
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Đăng nhập ngay để gặp ur better ver',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    M3TextField(
                      controller: _usernameController,
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    M3TextField(
                      controller: _passwordController,
                      labelText: 'Mật khẩu',
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Provider.of<CustomedRouterDelegate>(
                          context,
                          listen: false,
                        ).goRecoveryPassword(),
                        child: Text(
                          'Quên mật khẩu',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: M3LockedButton(
                        onPressed: () async {
                          if (!validateEmail(_usernameController.text.trim())) {
                            await showM3Popup(
                              context,
                              title: 'Cảnh báo',
                              descriptions: 'Email bạn nhập không hợp lệ',
                            );
                          } else if (_passwordController.text.trim().isEmpty) {
                            await showM3Popup(
                              context,
                              title: 'Cảnh báo',
                              descriptions: 'Bạn chưa nhập mật khẩu',
                            );
                          } else if (_passwordController.text.length < 6) {
                            await showM3Popup(
                              context,
                              title: 'Cảnh báo',
                              descriptions: '''
Độ dài tối thiểu của mật khẩu là 6 ký tự''',
                            );
                          } else {
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).login(
                              context,
                              email: _usernameController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        title: 'Đăng nhập',
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthenticationPlatformWidget(
                          iconPath: 'assets/icons/auth/login/ic_google.svg',
                          onPressed: () => context
                              .read<AuthProvider>()
                              .loginWithGoogle(context),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        AuthenticationPlatformWidget(
                          iconPath: 'assets/icons/auth/login/ic_facebook.svg',
                          onPressed: () => context
                              .read<AuthProvider>()
                              .loginWithFacebook(context),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Bạn chưa có tài khoản? ',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                          TextSpan(
                            text: 'Tạo ngay',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Provider.of<CustomedRouterDelegate>(
                                        context,
                                        listen: false,
                                      ).goSignUpScreen(),
                          ),
                        ],
                      ),
                    )
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
