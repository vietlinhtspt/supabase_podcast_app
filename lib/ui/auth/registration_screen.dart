import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../router/customed_router_delegate.dart';
import '../../shared/shared.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static String ROUTE_NAME = 'registration';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Tạo tài khoản,',
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
Tạo ngay tài khoản để có thể sử dụng tất cả dịch vụ của chúng tôi và đồng bộ hoá giữa các thiết bị của bạn''',
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
                      controller: _emailController,
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
                        onPressed: () => Provider.of<AuthProvider>(
                          context,
                          listen: false,
                        )
                            .register(
                              email: _emailController.text,
                              password: _passwordController.text,
                            )
                            .then((value) => value == true
                                ? Provider.of<CustomedRouterDelegate>(
                                    context,
                                    listen: false,
                                  ).backToLoginScreen()
                                : null),
                        title: 'Đăng ký',
                      ),
                    ),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'Bạn đã có tài khoản? ',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: 'Đăng nhập ngay',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap =
                                  () => Provider.of<CustomedRouterDelegate>(
                                        context,
                                        listen: false,
                                      ).backToLoginScreen(),
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
