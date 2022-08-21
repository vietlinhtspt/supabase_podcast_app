import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../providers/audio_provider.dart';
import 'components/components.dart';
import 'components/player_icon_widget.dart';

class MaximumPlayerWidget extends StatefulWidget {
  const MaximumPlayerWidget({Key? key}) : super(key: key);

  @override
  State<MaximumPlayerWidget> createState() => _MaximumPlayerWidgetState();
}

class _MaximumPlayerWidgetState extends State<MaximumPlayerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> sizeAnimation;
  double _topPadding = 0;

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
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
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
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedBuilder(
          animation: sizeAnimation,
          builder: (_, __) {
            return Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: sizeAnimation.value * screenHeight,
                  child: Container(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    height: screenHeight,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            width: 80,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Container(
                            height: 20,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Image.asset(
                                'assets/icons/home/ic_customed_line.png'),
                          ),
                          SizedBox(
                            height: screenHeight * 0.07,
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(70),
                                bottomRight: Radius.circular(20)),
                            child: CachedNetworkImage(
                              width: screenHeight * 0.35,
                              height: screenHeight * 0.35,
                              imageUrl: context
                                      .watch<AudioProvider>()
                                      .currentPodcastModel
                                      ?.imgPath ??
                                  'https://vcdtzzxxfqnbehzlyfne.supabase.co/storage/v1/object/sign/logos/melior_logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJsb2dvcy9tZWxpb3JfbG9nby5wbmciLCJpYXQiOjE2NjA5ODA0NzUsImV4cCI6MTk3NjM0MDQ3NX0.134_hv90KOVS4dWCLCqquvP5afwRGQ63FQx7yyWWwB0',
                            ),
                          ),
                          const SizedBox(height: 30),
                          // Show media item title
                          StreamBuilder<MediaItem?>(
                            stream: context
                                .watch<AudioProvider>()
                                .audioHandler
                                .mediaItem,
                            builder: (context, snapshot) {
                              final mediaItem = snapshot.data;
                              return Column(
                                children: [
                                  Text(
                                    mediaItem?.title ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  Text(
                                    mediaItem?.artist ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.07,
                          ),
                          StreamBuilder<MediaState>(
                            stream: _mediaStateStream(context),
                            builder: (context, snapshot) {
                              final mediaState = snapshot.data;
                              return SeekBar(
                                duration: mediaState?.mediaItem?.duration ??
                                    Duration.zero,
                                position: mediaState?.position ?? Duration.zero,
                                onChangeEnd: (newPosition) {
                                  context
                                      .read<AudioProvider>()
                                      .audioHandler
                                      .seek(newPosition);
                                },
                              );
                            },
                          ),
                          // Play/pause/stop buttons.
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PlayerIconWidget(
                                    iconPath:
                                        'assets/icons/player/ic_previous.svg',
                                    onPressed: context
                                        .watch<AudioProvider>()
                                        .audioHandler
                                        .rewind,
                                    height: 34,
                                  ),
                                  if (playing)
                                    PlayerIconWidget(
                                      iconPath:
                                          'assets/icons/player/ic_pause.svg',
                                      onPressed: context
                                          .watch<AudioProvider>()
                                          .audioHandler
                                          .pause,
                                      height: 34,
                                    )
                                  else
                                    PlayerIconWidget(
                                      iconPath:
                                          'assets/icons/player/ic_play.svg',
                                      onPressed: context
                                          .watch<AudioProvider>()
                                          .audioHandler
                                          .play,
                                      height: 34,
                                    ),
                                  PlayerIconWidget(
                                    iconPath: 'assets/icons/player/ic_next.svg',
                                    onPressed: context
                                        .watch<AudioProvider>()
                                        .audioHandler
                                        .fastForward,
                                    height: 34,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    _topPadding += details.primaryDelta!;
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

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> _mediaStateStream(BuildContext context) =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          context.watch<AudioProvider>().audioHandler.mediaItem,
          AudioService.position,
          (mediaItem, position) => MediaState(mediaItem, position));

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 64.0,
        onPressed: onPressed,
      );
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}
