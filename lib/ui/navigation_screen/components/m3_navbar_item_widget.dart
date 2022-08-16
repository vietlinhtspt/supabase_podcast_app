import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class M3NavbarItemWidget extends StatelessWidget {
  const M3NavbarItemWidget(
      {Key? key,
      required this.isSelected,
      required this.context,
      required this.title,
      required this.iconPath,
      required this.iconColor,
      required this.textColor,
      required this.onPressed,
      required this.width,
      required this.height})
      : super(key: key);

  final bool isSelected;
  final BuildContext context;
  final String title;
  final String iconPath;
  final Color iconColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: SvgPicture.asset(
                iconPath,
                color: iconColor,
                width: 24,
                height: 24,
              ),
            ),
            Positioned(
              top: 48,
              child: Text(
                title,
                style: TextStyle(
                  color: textColor,
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
