import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerIconWidget extends StatelessWidget {
  const PlayerIconWidget({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    this.color,
    this.height = 34,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback onPressed;
  final Color? color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: SizedBox(
        height: height,
        width: height,
        child: SvgPicture.asset(
          iconPath,
          fit: BoxFit.contain,
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
