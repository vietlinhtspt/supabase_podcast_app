import 'package:flutter/material.dart';

import 'components.dart';

class MaxPlayerMinControllerWidget extends StatelessWidget {
  const MaxPlayerMinControllerWidget({
    Key? key,
    required this.minPlayerHeight,
    required this.screenHeight,
    required this.screenWidth,
    required this.controller,
  }) : super(key: key);

  final int minPlayerHeight;
  final double screenHeight;
  final double screenWidth;
  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedPaddingWidget(
          children: [
            Container(
              margin: EdgeInsets.only(top: minPlayerHeight * 0.075),
              height: minPlayerHeight * 0.25,
              child: const MaxPlayerSeekBarWidget(
                hideTime: true,
              ),
            ),
            SizedBox(
              height: minPlayerHeight * 0.6,
              child: FittedBox(
                child: MaxPlayerMaximumControllerWidget(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  color: Colors.white,
                ),
              ),
            )
          ],
          duration: const Duration(seconds: 1),
          completedCallBack: (status) {},
          animateTween: Tween<double>(begin: 0, end: 1),
        ),
      ],
    );
  }
}
