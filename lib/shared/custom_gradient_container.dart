import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
