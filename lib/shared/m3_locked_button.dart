import 'dart:async';
import 'package:async/async.dart';

import 'package:flutter/material.dart';

import 'measure_size.dart';

class M3LockedButton extends StatefulWidget {
  const M3LockedButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final String title;
  final FutureOr<dynamic> Function() onPressed;

  @override
  State<M3LockedButton> createState() => _M3LockedButtonState();
}

class _M3LockedButtonState extends State<M3LockedButton> {
  var _isWaitingComplete = false;
  Size? _buttonSize;

  @override
  void didUpdateWidget(covariant M3LockedButton oldWidget) {
    if (mounted) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    CancelableOperation? _cancelableOperation;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ]),
        borderRadius: BorderRadius.circular(40),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // Foreground color
          foregroundColor: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Colors.transparent,
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: () {
          if (_cancelableOperation?.isCompleted ?? true) {
            _isWaitingComplete = true;
            if (mounted) setState(() {});
            _cancelableOperation =
                CancelableOperation.fromFuture(_onPressed()).then((p0) {
              _isWaitingComplete = false;
              if (mounted) setState(() {});
            });
          }
        },
        child: MeasureSize(
          onChange: (size) => setState(() {
            _buttonSize ??= size;
          }),
          child: SizedBox(
            width: _buttonSize?.width,
            height: _buttonSize?.height,
            child: _isWaitingComplete
                ? Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: FittedBox(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future _onPressed() async {
    return await widget.onPressed();
  }
}
