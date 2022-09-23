import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../providers/audio_provider.dart';
import '../../shared/shared.dart';
import 'components/player_icon_widget.dart';
import 'components/seek_bar.dart';
import 'maximum_player_widget.dart';

class MinimumPlayerWidget extends StatelessWidget {
  const MinimumPlayerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<AudioProvider>().showMaximumPlayer(),
      child: SizedBox(
        height: Responsive.isMobile(context) ? 75 : 110,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: Responsive.isMobile(context) ? 60 : 95,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                    ]),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: StreamBuilder<MediaItem?>(
                          stream: context
                              .watch<AudioProvider>()
                              .audioHandler
                              .mediaItem,
                          builder: (context, snapshot) {
                            final mediaItem = snapshot.data;
                            return Text(
                              mediaItem?.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                      if (!Responsive.isMobile(context))
                        Column(
                          children: [
                            SizedBox(
                              width: 400,
                              child: StreamBuilder<MediaState>(
                                stream: _mediaStateStream(context),
                                builder: (context, snapshot) {
                                  final mediaState = snapshot.data;
                                  return SeekBar(
                                    duration: mediaState?.mediaItem?.duration ??
                                        Duration.zero,
                                    position:
                                        mediaState?.position ?? Duration.zero,
                                    onChangeEnd: (newPosition) {
                                      context
                                          .read<AudioProvider>()
                                          .audioHandler
                                          .seek(newPosition);
                                    },
                                  );
                                },
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (!Responsive.isMobile(context))
                                      PlayerIconWidget(
                                        iconPath:
                                            'assets/icons/player/ic_previous.svg',
                                        onPressed: () => context
                                            .read<AudioProvider>()
                                            .playPrevious(context),
                                        color: Colors.white,
                                        height: 20,
                                      ),
                                    if (playing)
                                      PlayerIconWidget(
                                        iconPath:
                                            'assets/icons/player/ic_pause.svg',
                                        onPressed: context
                                            .watch<AudioProvider>()
                                            .audioHandler
                                            .pause,
                                        color: Colors.white,
                                        height: 20,
                                      )
                                    else
                                      PlayerIconWidget(
                                        iconPath:
                                            'assets/icons/player/ic_play.svg',
                                        onPressed: context
                                            .watch<AudioProvider>()
                                            .audioHandler
                                            .play,
                                        color: Colors.white,
                                        height: 20,
                                      ),
                                    PlayerIconWidget(
                                      iconPath:
                                          'assets/icons/player/ic_next.svg',
                                      onPressed: () => context
                                          .read<AudioProvider>()
                                          .playNext(context),
                                      color: Colors.white,
                                      height: 20,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      if (Responsive.isMobile(context))
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
                                if (playing)
                                  PlayerIconWidget(
                                    iconPath:
                                        'assets/icons/player/ic_pause.svg',
                                    onPressed: context
                                        .watch<AudioProvider>()
                                        .audioHandler
                                        .pause,
                                    color: Colors.white,
                                    height: 20,
                                  )
                                else
                                  PlayerIconWidget(
                                    iconPath: 'assets/icons/player/ic_play.svg',
                                    onPressed: context
                                        .watch<AudioProvider>()
                                        .audioHandler
                                        .play,
                                    color: Colors.white,
                                    height: 20,
                                  ),
                                PlayerIconWidget(
                                  iconPath: 'assets/icons/player/ic_next.svg',
                                  onPressed: () => context
                                      .read<AudioProvider>()
                                      .playNext(context),
                                  color: Colors.white,
                                  height: 20,
                                ),
                              ],
                            );
                          },
                        )
                      else
                        const Spacer()
                    ],
                  ),
                )),
            Positioned(
              left: 16,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(11)),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl: context
                              .watch<AudioProvider>()
                              .currentPodcastModel
                              ?.imgPath ??
                          'https://vcdtzzxxfqnbehzlyfne.supabase.co/storage/v1/object/sign/logos/melior_logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJsb2dvcy9tZWxpb3JfbG9nby5wbmciLCJpYXQiOjE2NjA5ODA0NzUsImV4cCI6MTk3NjM0MDQ3NX0.134_hv90KOVS4dWCLCqquvP5afwRGQ63FQx7yyWWwB0',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            if (Responsive.isMobile(context))
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: StreamBuilder<MediaState>(
                  stream: _mediaStateStream(context),
                  builder: (context, snapshot) {
                    final mediaState = snapshot.data;
                    return SeekBar(
                      duration:
                          mediaState?.mediaItem?.duration ?? Duration.zero,
                      position: mediaState?.position ?? Duration.zero,
                      onChangeEnd: (newPosition) {
                        context
                            .read<AudioProvider>()
                            .audioHandler
                            .seek(newPosition);
                      },
                      isShowTime: false,
                      isRemovePadding: Responsive.isMobile(context),
                      hideOverlay: Responsive.isMobile(context),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  /// A stream reporting the combined state of the current media item and its
  /// current position.
  Stream<MediaState> _mediaStateStream(BuildContext context) =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
        context.watch<AudioProvider>().audioHandler.mediaItem,
        AudioService.position,
        (mediaItem, position) => MediaState(mediaItem, position),
      );
}
