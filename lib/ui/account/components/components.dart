import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/shared.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: CustomGradientContainer(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.primary,
        ]),
        child: TextButton(
          onPressed: onTap,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width > 342
                ? 342
                : MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  iconPath,
                  color: Theme.of(context).colorScheme.primary,
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
