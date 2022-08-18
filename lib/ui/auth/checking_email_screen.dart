import 'package:flutter/material.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/shared.dart';

class CheckingEmailScreen extends StatelessWidget {
  const CheckingEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              'Kiểm tra email của bạn,',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 45,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              '''
Chúng tôi đã gửi một email xác nhận. Vui lòng mở link được gửi kèm email để kích hoạt tài khoản. Nếu bạn không thấy vui lòng kiểm tra trong danh sách spam hoặc thử với email khác.''',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            M3LockedButton(
              title: 'Mở ứng dụng email',
              onPressed: () async {
                // final params = Uri(
                //   scheme: 'mailto',
                // );

                // await launchUrl(params);
                var result = await OpenMailApp.openMailApp();

                // If no mail apps found, show error
                if (!result.didOpen && !result.canOpen) {
                  // showNoMailAppsDialog(context);

                  // iOS: if multiple mail apps found, show dialog to select.
                  // There is no native intent/default app system in iOS so
                  // you have to do it yourself.
                } else if (!result.didOpen && result.canOpen) {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return MailAppPickerDialog(
                        mailApps: result.options,
                      );
                    },
                  );
                }
              },
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
