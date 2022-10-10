import 'package:flutter/material.dart';

class MaxPlayerSwiftIcon extends StatelessWidget {
  const MaxPlayerSwiftIcon({
    Key? key,
    required this.controllerValueReversed,
    required AnimationController controller,
  })  : _controller = controller,
        super(key: key);

  final double controllerValueReversed;
  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10 * controllerValueReversed),
      width: 80,
      height: 8 *
          (controllerValueReversed > 0.5 ? (0.5 - _controller.value) * 2 : 0),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ]),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
