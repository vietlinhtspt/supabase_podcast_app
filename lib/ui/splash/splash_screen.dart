import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/user_info_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<UserInfoProvider>().getUserInfo(context).then(
            (value) => context.read<AuthProvider>().completeInitData(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
          child: Text(
        'Loading !!!!!\n\n Đang tải dữ liệu',
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      )),
    );
  }
}
