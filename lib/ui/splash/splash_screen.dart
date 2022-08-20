import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_info.dart';
import '../../providers/providers.dart';

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
      Future.wait([
        context.read<UserInfoProvider>().getUserInfo(context),
        context.read<PodcastProvider>().fetch(context),
      ]).then(
        (value) {
          if ((value[0] as UserInfo?)?.email != null) {
            context.read<UserInfoProvider>().subcribe();
          }
          context.read<AuthProvider>().completeInitData();
        },
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
