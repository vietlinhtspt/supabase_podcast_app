import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class M3TextFieldIconWidget extends StatelessWidget {
  const M3TextFieldIconWidget({
    Key? key,
    this.onTap,
    required this.iconPath,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SvgPicture.asset(
          iconPath,
          height: 20,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
