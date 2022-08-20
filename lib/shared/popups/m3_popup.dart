import 'package:flutter/material.dart';

import 'components/m3_popup_widget.dart';

Future<void> showM3Popup(
  BuildContext context, {
  String? title,
  required String descriptions,
  List<String>? textActions,
  Function(String value)? onTapAction,
}) {
  // for hide keyboard
  FocusScope.of(context).requestFocus(FocusNode());
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return M3PopupPupupWidget(
          title: title,
          descriptions: descriptions,
          textActions: textActions,
          onTapAction: onTapAction,
        );
      });
}
