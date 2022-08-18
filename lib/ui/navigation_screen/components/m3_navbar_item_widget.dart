import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:flutter_svg/svg.dart';

class M3NavbarItemWidget extends StatelessWidget {
  const M3NavbarItemWidget(
      {Key? key,
      required this.isSelected,
      required this.context,
      required this.title,
      required this.iconPath,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);

  final bool isSelected;
  final BuildContext context;
  final String title;
  final String iconPath;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected
        ? null
        : Theme.of(context)
            .colorScheme
            .onPrimaryContainer
            .mix(Theme.of(context).colorScheme.primaryContainer, 0.25);
    final textColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context)
            .colorScheme
            .onPrimaryContainer
            .mix(Theme.of(context).colorScheme.primaryContainer, 0.25);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: SizedBox(
        height: height,
        width: width,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 16,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: isSelected ? Curves.decelerate : Curves.ease,
                width: isSelected ? 64 : 0,
                height: 32,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary.mix(
                        Theme.of(context).colorScheme.primaryContainer,
                        0.85,
                      ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 14,
              child: Image.asset(
                iconPath,
                color: iconColor,
                width: 34,
                height: 34,
              ),
            ),
            Positioned(
              top: 48,
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QRInfoNavigationBarItem {
  QRInfoNavigationBarItem({
    required this.iconPath,
    required this.iconPathSelected,
    required this.text,
  });
  String iconPath;
  String iconPathSelected;
  String text;
}
