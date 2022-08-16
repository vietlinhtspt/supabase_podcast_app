import 'dart:async';
import 'package:async/async.dart';

import 'package:flutter/material.dart';

class M3LockedButton extends StatelessWidget {
  const M3LockedButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final String title;
  final FutureOr<dynamic> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    CancelableOperation? _cancelableOperation;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: Theme.of(context).colorScheme.onSecondaryContainer,
        // Background color
        primary: Theme.of(context).colorScheme.secondaryContainer,
      ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
      onPressed: () {
        if (_cancelableOperation?.isCompleted ?? true) {
          _cancelableOperation = CancelableOperation.fromFuture(_onPressed());
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future _onPressed() async {
    return await onPressed();
  }
}
