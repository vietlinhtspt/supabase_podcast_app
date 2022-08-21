import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        context.read<PodcastProvider>().fetch(context,
            email: Supabase.instance.client.auth.currentUser!.email!),
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
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30),
              child: Image.asset(
                'assets/logos/melior_rounded_logo.png',
                width: 180,
                height: 180,
              ),
            ),
            Image.asset(
              'assets/logos/melior_text_logo.png',
              height: 50,
            ),
            const SizedBox(
              height: 40,
            ),
            Lottie.asset(
              'assets/animations/loading.json',
              height: 100,
            ),
            Text(
              'spash_screen.title'.tr(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
