import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';
import 'player_icon_widget.dart';

class MaxPlayerMaximumControllerWidget extends StatelessWidget {
  const MaxPlayerMaximumControllerWidget({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
    this.color,
  }) : super(key: key);

  final double screenHeight;
  final double screenWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: context
          .watch<AudioProvider>()
          .audioHandler
          .playbackState
          .map((state) => state.playing)
          .distinct(),
      builder: (context, snapshot) {
        final playing = snapshot.data ?? false;
        return SizedBox(
          width: screenWidth > 380 ? 380 : screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PlayerIconWidget(
                iconPath: 'assets/icons/player/ic_shuffle.svg',
                onPressed: () => null,
                height: screenHeight * 0.04,
                color: color,
              ),
              PlayerIconWidget(
                iconPath: 'assets/icons/player/ic_previous.svg',
                onPressed: () =>
                    context.read<AudioProvider>().playPrevious(context),
                height: screenHeight * 0.04,
                color: color,
              ),
              if (playing)
                PlayerIconWidget(
                  iconPath: 'assets/icons/player/ic_pause.svg',
                  onPressed: context.watch<AudioProvider>().audioHandler.pause,
                  height: screenHeight * 0.04,
                  isShowBackground: false,
                  color: color,
                )
              else
                PlayerIconWidget(
                  iconPath: 'assets/icons/player/ic_play.svg',
                  onPressed: context.watch<AudioProvider>().audioHandler.play,
                  height: screenHeight * 0.04,
                  isShowBackground: false,
                  isIconPlay: true,
                  color: color,
                ),
              PlayerIconWidget(
                iconPath: 'assets/icons/player/ic_next.svg',
                onPressed: () =>
                    context.read<AudioProvider>().playNext(context),
                height: screenHeight * 0.04,
                color: color,
              ),
              PlayerIconWidget(
                iconPath: 'assets/icons/player/ic_loop.svg',
                onPressed: () => null,
                height: screenHeight * 0.04,
                color: color,
              ),
            ],
          ),
        );
      },
    );
  }
}
