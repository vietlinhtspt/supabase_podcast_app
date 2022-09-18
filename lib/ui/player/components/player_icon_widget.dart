import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlayerIconWidget extends StatelessWidget {
  const PlayerIconWidget({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    this.color,
    this.height = 34,
    this.isShowBackground = false,
    this.isIconPlay = false,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback onPressed;
  final Color? color;
  final double height;
  final bool isShowBackground;
  final defaultPadding = 16.0;
  final bool isIconPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isShowBackground
          ? EdgeInsets.fromLTRB(
              isIconPlay ? defaultPadding + 5 : defaultPadding,
              defaultPadding,
              defaultPadding,
              defaultPadding,
            )
          : null,
      width: height + defaultPadding * 2,
      height: height + defaultPadding * 2,
      decoration: isShowBackground
          ? BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            )
          : null,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.zero,
          ),
        ),
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
      ),
    );
  }
}
