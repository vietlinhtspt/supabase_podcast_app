import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationPlatformWidget extends StatelessWidget {
  const AuthenticationPlatformWidget({
    Key? key,
    required this.iconPath,
    this.onPressed,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(16),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: SvgPicture.asset(
        iconPath,
        width: 32,
        height: 32,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
