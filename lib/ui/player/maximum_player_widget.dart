import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/audio_provider.dart';
import '../../shared/shared.dart';
import '../navigation_screen/components/qr_info_navigation_bar.dart';
import 'components/components.dart';

class MaximumPlayerMobileWidget extends StatefulWidget {
  const MaximumPlayerMobileWidget({Key? key}) : super(key: key);

  @override
  State<MaximumPlayerMobileWidget> createState() =>
      _MaximumPlayerMobileWidgetState();
}

class _MaximumPlayerMobileWidgetState extends State<MaximumPlayerMobileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> sizeAnimation;
  double _topPadding = 0;
  final height = 60;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..addListener(() {
        if (_controller.value == 0) {
          context.read<AudioProvider>().isMaximumSize = false;
        } else if (_controller.value == 1) {
          context.read<AudioProvider>().isMaximumSize = true;
        }
      });
    sizeAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AudioProvider>().addListener(() {
        if (context.read<AudioProvider>().isMaximumSize == true &&
            _controller.value == 1 &&
            mounted) {
          _controller.reverse();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final navbarHeight =
        (Responsive.isMobile(context) ? QRInfoNavigationBar.HEIGHT : 0);

    final minPlayerHeight = Responsive.isMobile(context) ? 62 : 80;
    final minTopPosition = screenHeight - minPlayerHeight - navbarHeight;
    final minPodcastImageSize = minPlayerHeight * 2 / 3;

    final isVertical = !Responsive.isMobile(context);
    final leftPadding = isVertical ? QRInfoNavigationBar.HEIGHT : 16;
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      onTap: () => context.read<AudioProvider>().showMaximumPlayer(),
      child: AnimatedBuilder(
        animation: sizeAnimation,
        builder: (_, __) {
          final controllerValueReversed = 1 - _controller.value;
          final topPosition = screenHeight * _controller.value > minTopPosition
              ? minTopPosition
              : screenHeight * _controller.value;
          final podcastImageSize = (screenHeight * 0.35 - minPodcastImageSize) *
                  controllerValueReversed +
              minPodcastImageSize;
          print(_controller.value);
          return Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: topPosition,
                child: Container(
                  height: (screenHeight - minPlayerHeight) *
                          controllerValueReversed +
                      minPlayerHeight,
                  decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ]),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: isVertical
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          height: 2,
                          child: MaxPlayerSeekBarWidget(
                            isHideOverlayAndTime: true,
                            isRemovePadding: true,
                          ),
                        ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: topPosition,
                child: Container(
                  color: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(
                        controllerValueReversed < 0.5
                            ? (1 - (_controller.value - 0.5) * 2)
                            : 1,
                      ),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top *
                        controllerValueReversed,
                    bottom: MediaQuery.of(context).padding.bottom *
                        controllerValueReversed,
                  ),
                  height: screenHeight,
                  child: Column(
                    children: [
                      MaxPlayerSwiftIcon(
                        controllerValueReversed: controllerValueReversed,
                        controller: _controller,
                      ),
                      SizedBox(
                        height: screenHeight * 0.03 * controllerValueReversed,
                      ),

                      Transform.translate(
                        offset: Offset(
                          -screenWidth *
                              (_controller.value < 0.5
                                  ? _controller.value * 2
                                  : 1),
                          0,
                        ),
                        child: Container(
                          height: 20 * controllerValueReversed,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset(
                              'assets/icons/home/ic_customed_line.png'),
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.03 * controllerValueReversed,
                      ),
                      MaxPlayerPodcastImageWidget(
                        screenWidth: screenWidth,
                        podcastImageSize: podcastImageSize,
                        controller: _controller,
                        controllerValueReversed: controllerValueReversed,
                      ),
                      SizedBox(height: 30 * controllerValueReversed),
                      // Show media item title
                      MaxPlayerTitleWithMinControllerMobile(
                        podcastImageSize: podcastImageSize,
                        controller: _controller,
                        screenWidth: screenWidth,
                        controllerValueReversed: controllerValueReversed,
                        screenHeight: screenHeight,
                        minPlayerHeight: minPlayerHeight,
                      ),
                      SizedBox(
                        height: screenHeight * 0.03 * controllerValueReversed,
                      ),
                      if ((_controller.value < 0.5 && !isVertical) ||
                          isVertical)
                        MaxPlayerControllerWidget(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                        ),

                      const Spacer(),
                      RotatedBox(
                        quarterTurns: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Image.asset(
                            'assets/icons/home/ic_customed_line.png',
                            height: controllerValueReversed * 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30 * controllerValueReversed,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _topPadding += details.delta.dy;
    if (_topPadding < 0) {
      _topPadding = 0;
    } else if (_topPadding > MediaQuery.of(context).size.height) {
      _topPadding = MediaQuery.of(context).size.height;
    }
    _controller.value = _topPadding / MediaQuery.of(context).size.height;

    if (mounted) setState(() {});
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (_controller.value < 0.5) {
      _controller.reverse();
      _topPadding = 0;
    } else {
      _controller.forward();
      _topPadding = 1;
    }
  }
}
