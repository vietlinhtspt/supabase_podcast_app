import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationPlatformWidget extends StatelessWidget {
  const AuthenticationPlatformWidget({
    Key? key,
    this.iconPath,
    this.child,
    this.onPressed,
  }) : super(key: key);

  final String? iconPath;
  final Widget? child;
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
      child: iconPath != null
          ? SvgPicture.asset(
              iconPath!,
              width: 32,
              height: 32,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            )
          : child ?? const SizedBox.shrink(),
    );
  }
}
