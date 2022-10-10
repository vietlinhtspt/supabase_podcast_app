import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../providers/providers.dart';

import 'seek_bar.dart';

class MaxPlayerSeekBarWidget extends StatelessWidget {
  const MaxPlayerSeekBarWidget({
    Key? key,
    required AnimationController controller,
    required this.screenWidth,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth > 420 ? 420 : screenWidth,
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
            hideOverlay: _controller.value > 0.5,
            isShowTime: _controller.value < 0.5,
            isRemovePadding: _controller.value > 0.5,
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
