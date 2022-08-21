import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    this.height = 30,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/logos/melior_logo.png',
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(width: 6),
          Text(
            'Meilor',
            style: TextStyle(
              fontSize: (height / 30) * 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
