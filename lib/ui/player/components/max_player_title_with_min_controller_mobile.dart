import 'dart:math' as math;
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';
import '../../../shared/responsive.dart';
import 'components.dart';
import 'player_icon_widget.dart';

class MaxPlayerTitleWithMinControllerMobile extends StatelessWidget {
  const MaxPlayerTitleWithMinControllerMobile({
    Key? key,
    required this.podcastImageSize,
    required AnimationController controller,
    required this.screenWidth,
    required this.controllerValueReversed,
    required this.screenHeight,
    required this.minPlayerHeight,
  })  : _controller = controller,
        super(key: key);

  final double podcastImageSize;
  final AnimationController _controller;
  final double screenWidth;
  final double controllerValueReversed;
  final double screenHeight;
  final int minPlayerHeight;

  @override
  Widget build(BuildContext context) {
    final _controllerSize = Responsive.isMobile(context)
        ? 100.0 * _controller.value
        : MediaQuery.of(context).size.width * _controller.value / 3;
    final _rightPaddingSize =
        (screenWidth - _controllerSize) / 2 * _controller.value;
    return Transform.translate(
      offset: Offset(
        0,
        -(podcastImageSize * _controller.value),
      ),
      child: StreamBuilder<MediaItem?>(
        stream: context.watch<AudioProvider>().audioHandler.mediaItem,
        builder: (context, snapshot) {
          final mediaItem = snapshot.data;
          return Padding(
            padding: EdgeInsets.only(
              left: (16 * 2 + podcastImageSize) * _controller.value,
              top: 6 * _controller.value,
            ),
            child: Row(
              children: [
                TitleWidget(
                  screenWidth: screenWidth,
                  controller: _controller,
                  mediaItem: mediaItem,
                  controllerValueReversed: controllerValueReversed,
                ),
                MinControllerMobileWidget(
                    controllerSize: _controllerSize,
                    screenHeight: screenHeight,
                    controller: _controller,
                    minPlayerHeight: minPlayerHeight,
                    screenWidth: screenWidth),
                if (!Responsive.isMobile(context))
                  SizedBox(width: _rightPaddingSize)
              ],
            ),
          );
        },
      ),
    );
  }
}

class TitleWidget extends StatefulWidget {
  const TitleWidget({
    Key? key,
    required this.screenWidth,
    required AnimationController controller,
    required this.mediaItem,
    required this.controllerValueReversed,
  })  : _controller = controller,
        super(key: key);

  final double screenWidth;
  final AnimationController _controller;
  final MediaItem? mediaItem;
  final double controllerValueReversed;

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: widget.screenWidth,
            alignment: widget._controller.value < 1
                ? AlignmentDirectional.center
                : AlignmentDirectional.centerStart,
            child: Text(
              widget.mediaItem?.title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16 + 6 * widget.controllerValueReversed,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface.mix(
                    Theme.of(context).colorScheme.primaryContainer,
                    widget._controller.value),
              ),
            ),
          ),
          Container(
            width: widget.screenWidth,
            alignment: widget._controller.value < 1
                ? AlignmentDirectional.center
                : AlignmentDirectional.centerStart,
            child: Text(
              widget.mediaItem?.artist ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacity(0.7)
                    .mix(Theme.of(context).colorScheme.primaryContainer,
                        widget._controller.value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MinControllerMobileWidget extends StatelessWidget {
  const MinControllerMobileWidget({
    Key? key,
    required double controllerSize,
    required this.screenHeight,
    required AnimationController controller,
    required this.minPlayerHeight,
    required this.screenWidth,
  })  : _controllerSize = controllerSize,
        _controller = controller,
        super(key: key);

  final double _controllerSize;
  final double screenHeight;
  final AnimationController _controller;
  final int minPlayerHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _controllerSize,
      child: StreamBuilder<bool>(
        stream: context
            .watch<AudioProvider>()
            .audioHandler
            .playbackState
            .map((state) => state.playing)
            .distinct(),
        builder: (context, snapshot) {
          final playing = snapshot.data ?? false;
          return Responsive.isMobile(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (playing)
                      PlayerIconWidget(
                        iconPath: 'assets/icons/player/ic_pause.svg',
                        onPressed:
                            context.watch<AudioProvider>().audioHandler.pause,
                        color: Theme.of(context).colorScheme.onPrimary,
                        height: screenHeight * 0.03 * _controller.value,
                        defaultPadding: 8 * _controller.value,
                        isShowBackground: false,
                      )
                    else
                      PlayerIconWidget(
                        iconPath: 'assets/icons/player/ic_play.svg',
                        onPressed:
                            context.watch<AudioProvider>().audioHandler.play,
                        color: Theme.of(context).colorScheme.onPrimary,
                        height: screenHeight * 0.03 * _controller.value,
                        defaultPadding: 8 * _controller.value,
                        isShowBackground: false,
                        isIconPlay: true,
                      ),
                    PlayerIconWidget(
                      iconPath: 'assets/icons/player/ic_next.svg',
                      onPressed: () =>
                          context.read<AudioProvider>().playNext(context),
                      color: Theme.of(context).colorScheme.onPrimary,
                      height: screenHeight * 0.03 * _controller.value,
                      defaultPadding: 8 * _controller.value,
                    ),
                  ],
                )
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _controller.value > 0.99
                      ? MaxPlayerMinControllerWidget(
                          minPlayerHeight: minPlayerHeight,
                          controller: _controller,
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        )
                      : const SizedBox.shrink(),
                );
        },
      ),
    );
  }
}
