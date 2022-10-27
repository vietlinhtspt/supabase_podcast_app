import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../providers/providers.dart';

import 'seek_bar.dart';

class MaxPlayerSeekBarWidget extends StatelessWidget {
  const MaxPlayerSeekBarWidget({
    Key? key,
    this.screenWidth,
    this.isHideOverlayAndTime = false,
    this.isRemovePadding = false,
    this.hideTime = false,
  }) : super(key: key);

  final double? screenWidth;
  final bool isHideOverlayAndTime;
  final bool isRemovePadding;
  final bool hideTime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth != null
          ? screenWidth! > 420
              ? 420
              : screenWidth
          : null,
      child: StreamBuilder<MediaState>(
        stream: _mediaStateStream(context),
        builder: (context, snapshot) {
          final mediaState = snapshot.data;
          return SeekBar(
            duration: mediaState?.mediaItem?.duration ?? Duration.zero,
            position: mediaState?.position ?? Duration.zero,
            onChangeEnd: (newPosition) {
              context.read<AudioProvider>().audioHandler.seek(newPosition);
            },
            hideOverlay: isHideOverlayAndTime,
            isShowTime: !isHideOverlayAndTime && !hideTime,
            isRemovePadding: isRemovePadding,
          );
        },
      ),
    );
  }

  Stream<MediaState> _mediaStateStream(BuildContext context) =>
      Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          context.watch<AudioProvider>().audioHandler.mediaItem,
          AudioService.position,
          (mediaItem, position) => MediaState(mediaItem, position));
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}
