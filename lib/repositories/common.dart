import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../shared/popups/m3_popup.dart';

Future supabaseCallAPI(
  BuildContext context, {
  required Function function,
}) async {
  try {
    await function();
  } on GoTrueException catch (e, stacktrace) {
    await showM3Popup(context,
        descriptions: e.message, title: 'popup.error'.tr());
    debugPrint(stacktrace.toString());
  } catch (e, stacktrace) {
    await showM3Popup(context,
        descriptions: 'popup.unknown_error'.tr(), title: 'popup.error'.tr());
    debugPrint(stacktrace.toString());
  }
}
