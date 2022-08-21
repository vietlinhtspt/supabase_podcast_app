import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../router/customed_router_delegate.dart';
import '../../shared/shared.dart';
import 'checking_email_screen.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({Key? key}) : super(key: key);

  static String ROUTE_NAME = 'recoveryPassword';

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMaximunHeight = MediaQuery.of(context).size.width >= 500;
    return Scaffold(
      body: GestureDetector(
        onTap: () => hideKeyboard(),
        child: Container(
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
                  height: isMaximunHeight
                      ? null
                      : MediaQuery.of(context).size.height,
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
                          'recovery_password.recovery_password'.tr(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 45,
                            height: 0.9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'recovery_password.solo_gan'.tr(),
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
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
                        height: 32,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: M3LockedButton(
                          onPressed: () async {
                            if (!validateEmail(_emailController.text.trim())) {
                              await showM3Popup(
                                context,
                                title: 'popup.warning'.tr(),
                                descriptions: 'popup.not_valid_email'.tr(),
                              );
                            } else {
                              await context
                                  .read<AuthProvider>()
                                  .requestRecoveryPassword(
                                    context,
                                    email: _emailController.text,
                                  )
                                  .then(
                                    (value) => value == true
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CheckingEmailScreen(),
                                            ),
                                          )
                                        : null,
                                  );
                            }
                          },
                          title: 'recovery_password.recovery'.tr(),
                        ),
                      ),
                      const Spacer(),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.fontFamily,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  // ignore: lines_longer_than_80_chars
                                  '${'recovery_password.do_you_already_have_an_account'.tr()}? ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'recovery_password.log_in_now'.tr(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
