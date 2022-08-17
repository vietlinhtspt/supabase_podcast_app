import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../ui/auth/components/m3_text_field_icon_widget.dart';

class M3TextField extends StatefulWidget {
  const M3TextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool? obscureText;

  @override
  State<M3TextField> createState() => _M3TextFieldState();
}

class _M3TextFieldState extends State<M3TextField> {
  late TextEditingController controller;
  late String labelText;
  bool? obscureText;

  @override
  void initState() {
    controller = widget.controller;
    labelText = widget.labelText;
    obscureText = widget.obscureText;
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant M3TextField oldWidget) {
    controller = widget.controller;
    labelText = widget.labelText;
    obscureText = widget.obscureText;
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomGradientContainer(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ]),
          child: TextField(
            cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
            controller: controller,
            obscureText: obscureText ?? false,
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: const BorderSide(
                  width: 1,
                  style: BorderStyle.solid,
                  color: Colors.transparent,
                ),
              ),
              label: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text(labelText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w400,
                    )),
              ),
              floatingLabelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.w400,
              ),
              hoverColor: Colors.transparent,
              fillColor: Colors.transparent,
              suffixIcon: obscureText == null && controller.text.isNotEmpty
                  ? M3TextFieldIconWidget(
                      iconPath: 'assets/icons/auth/ic_remove_rounded.svg',
                      onTap: () => controller.clear(),
                    )
                  : obscureText == true
                      ? M3TextFieldIconWidget(
                          iconPath: 'assets/icons/auth/ic_show_content.svg',
                          onTap: () => setState(() {
                            obscureText = !(obscureText ?? false);
                          }),
                        )
                      : obscureText == false
                          ? M3TextFieldIconWidget(
                              iconPath: 'assets/icons/auth/ic_hide_content.svg',
                              onTap: () => setState(() {
                                obscureText = !(obscureText ?? false);
                              }),
                            )
                          : null,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomGradient extends CustomPainter {
  CustomGradient({required this.gradient, required this.sWidth});

  final Gradient gradient;
  final double sWidth;
  final Paint p = Paint();
  final borderRadius = 15.0;

  @override
  void paint(Canvas canvas, Size size) {
    final outerRect = Offset.zero & size;
    p.shader = gradient.createShader(outerRect);
    final borderPath = _calculateBorderPath(size);

    canvas.drawPath(borderPath, p);
  }

  Path _calculateBorderPath(Size size) {
    final outerPath = _createPath(size);
    final innerPath = _createPath(size, padding: sWidth);

    return Path.combine(PathOperation.difference, outerPath, innerPath);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Path _createPath(Size size, {double padding = 0}) {
    return Path()
      ..moveTo(size.width / 2, padding)
      ..lineTo(size.width - (borderRadius - padding), padding)
      ..arcToPoint(Offset(size.width - padding, (borderRadius - padding)),
          radius: Radius.circular((borderRadius - padding)))
      ..lineTo(size.width - padding,
          size.height - (borderRadius - padding) - padding)
      ..arcToPoint(
        Offset(size.width - padding - (borderRadius - padding),
            size.height - padding),
        radius: Radius.circular((borderRadius - padding)),
      )
      ..lineTo(borderRadius * 2 - padding, size.height - padding)
      ..arcToPoint(
        Offset(padding, size.height - borderRadius * 2 - padding - padding),
        radius: Radius.circular(borderRadius * 2 - padding),
      )
      ..lineTo(padding, (borderRadius - padding))
      ..arcToPoint(
        Offset((borderRadius - padding), padding),
        radius: Radius.circular((borderRadius - padding)),
      )
      ..moveTo(size.width / 2, padding)
      ..close();
  }
}

class CustomGradientContainer extends StatelessWidget {
  CustomGradientContainer({
    Key? key,
    required gradient,
    required this.child,
    this.strokeWidth = 1,
  })  : painter = CustomGradient(gradient: gradient, sWidth: strokeWidth),
        super(key: key);

  final CustomGradient painter;
  final Widget child;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: child,
          )
        : CustomPaint(painter: painter, child: child);
  }
}
