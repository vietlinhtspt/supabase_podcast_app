import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPaddingWidget extends StatefulWidget {
  const AnimatedPaddingWidget({
    Key? key,
    required this.children,
    required this.duration,
    this.startPoint = const Offset(0, 100),
    this.completedCallBack,
    this.curve,
    this.activeOpacity,
    this.animateTween,
  }) : super(key: key);

  final List<Widget> children;
  final Duration? duration;
  final Offset startPoint;
  final Curve? curve;
  final bool? activeOpacity;
  final Function(AnimationStatus status)? completedCallBack;

  /// tween for animated
  final Tween<double>? animateTween;
  @override
  State<AnimatedPaddingWidget> createState() => _AnimatedPaddingWidgetState();
}

class _AnimatedPaddingWidgetState extends State<AnimatedPaddingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    /// init animation
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    animation = (widget.animateTween ?? Tween<double>(begin: 0, end: 1))
        .animate(CurvedAnimation(
            parent: animationController,
            curve: widget.curve ?? Curves.decelerate))
      ..addStatusListener((status) {
        // print({status});

        /// call status
        widget.completedCallBack?.call(status);
      });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextAnimated(
      activeOpacity: widget.activeOpacity,
      children: widget.children,
      // textStyle: widget.textStyle,
      startPoint: widget.startPoint,
      listenable: animation,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class TextAnimated extends AnimatedWidget {
  TextAnimated({
    Key? key,
    required Listenable listenable,
    required this.children,
    this.activeOpacity,
    required this.startPoint,
  }) : super(key: key, listenable: listenable);
  final List<Widget> children;
  final bool? activeOpacity;
  final Offset startPoint;
  double _add = 0;
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    // print("========");
    // print(animation.value * 3);
    // _add += (0.5 * 9.8 * pow(animation.value * 3, 2));
    // print(_add);
    return Opacity(
      opacity: activeOpacity == false ? 1 : animation.value,
      child: Transform.translate(
        offset: getOffset(animation),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children.asMap().entries.toList().map<Widget>((e) {
            if (e.key < children.length - 1) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  e.value,
                  SizedBox(
                    height: (1 - animation.value) * 40 * (e.key + 1),
                  ),
                ],
              );
            } else {
              return e.value;
            }
          }).toList(),
        ),
      ),
    );
  }

  Offset getOffset(animation) {
    return Offset(
      (1 - animation.value) * startPoint.dx,
      (1 - animation.value) * startPoint.dy,
    );
  }
}
