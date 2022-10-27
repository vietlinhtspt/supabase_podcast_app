import 'package:flutter/material.dart';

import 'components.dart';

class MaxPlayerControllerWidget extends StatelessWidget {
  const MaxPlayerControllerWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    this.height,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaxPlayerSeekBarWidget(
            screenWidth: screenWidth,
          ),
          MaxPlayerMaximumControllerWidget(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }
}
