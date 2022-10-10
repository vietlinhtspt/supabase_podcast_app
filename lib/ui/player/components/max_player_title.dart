import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';
import 'player_icon_widget.dart';

class MaxPlayerTitle extends StatelessWidget {
  const MaxPlayerTitle({
    Key? key,
    required this.podcastImageSize,
    required AnimationController controller,
    required this.screenWidth,
    required this.controllerValueReversed,
    required this.screenHeight,
  })  : _controller = controller,
        super(key: key);

  final double podcastImageSize;
  final AnimationController _controller;
  final double screenWidth;
  final double controllerValueReversed;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        0,
        -(podcastImageSize * _controller.value),
      ),
      child: StreamBuilder<MediaItem?>(
        stream: context.watch<AudioProvider>().audioHandler.mediaItem,
        builder: (context, snapshot) {
          final mediaItem = snapshot.data;
          return Container(
            padding: EdgeInsets.only(
              left: (16 * 2 + podcastImageSize) * _controller.value,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth,
                        alignment: _controller.value < 1
                            ? AlignmentDirectional.center
                            : AlignmentDirectional.centerStart,
                        child: Text(
                          mediaItem?.title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16 + 6 * controllerValueReversed,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface.mix(
                                Theme.of(context).colorScheme.primaryContainer,
                                _controller.value),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        alignment: _controller.value < 1
                            ? AlignmentDirectional.center
                            : AlignmentDirectional.centerStart,
                        child: Text(
                          mediaItem?.artist ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.7)
                                .mix(
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    _controller.value),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                  stream: context
                      .watch<AudioProvider>()
                      .audioHandler
                      .playbackState
                      .map((state) => state.playing)
                      .distinct(),
                  builder: (context, snapshot) {
                    final playing = snapshot.data ?? false;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (playing)
                          PlayerIconWidget(
                            iconPath: 'assets/icons/player/ic_pause.svg',
                            onPressed: context
                                .watch<AudioProvider>()
                                .audioHandler
                                .pause,
                            color: Theme.of(context).colorScheme.onPrimary,
                            height: screenHeight * 0.03 * _controller.value,
                            defaultPadding: 16 * _controller.value,
                            isShowBackground: false,
                          )
                        else
                          PlayerIconWidget(
                            iconPath: 'assets/icons/player/ic_play.svg',
                            onPressed: context
                                .watch<AudioProvider>()
                                .audioHandler
                                .play,
                            color: Theme.of(context).colorScheme.onPrimary,
                            height: screenHeight * 0.03 * _controller.value,
                            defaultPadding: 16 * _controller.value,
                            isShowBackground: false,
                            isIconPlay: true,
                          ),
                        PlayerIconWidget(
                          iconPath: 'assets/icons/player/ic_next.svg',
                          onPressed: () =>
                              context.read<AudioProvider>().playNext(context),
                          color: Theme.of(context).colorScheme.onPrimary,
                          height: screenHeight * 0.03 * _controller.value,
                          defaultPadding: 16 * _controller.value,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
