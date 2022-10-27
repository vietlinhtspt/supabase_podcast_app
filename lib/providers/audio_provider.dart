import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/podcast_info_model.dart';
import 'providers.dart';

class AudioProvider extends ChangeNotifier {
  late AudioHandler _audioHandler;
  bool isMaximumSize = false;
  PodcastInfoModel? _currentPodcastModel;

  AudioProvider({required AudioHandler audioHandler}) {
    _audioHandler = audioHandler;
  }

  AudioHandler get audioHandler => _audioHandler;
  PodcastInfoModel? get currentPodcastModel => _currentPodcastModel;

  void showMaximumPlayer() {
    isMaximumSize = true;
    notifyListeners();
  }

  void play(PodcastInfoModel newPodcastModel) {
    _currentPodcastModel = newPodcastModel;
    if (_currentPodcastModel != null) {
      _audioHandler.playMediaItem(_currentPodcastModel!.toMediaItem);
      //       .then((value) {
      //     print('podcastHistory?.first.listened:');
      //     print(newPodcastModel.podcastHistory?.first.listened);
      //     if (newPodcastModel.podcastHistory?.first.listened != null) {
      //       _audioHandler
      //           .seek(Duration(
      //             seconds: newPodcastModel.podcastHistory!.first.listened!,
      //           ))
      //           .then((value) => _audioHandler.play());
      //     }
      //   });
    }

    isMaximumSize = true;
    notifyListeners();
  }

  void playNext(BuildContext context) {
    final currentPodcastIndex = context
        .read<PodcastProvider>()
        .podcast
        .indexWhere((element) => element.id == currentPodcastModel?.id);

    if (currentPodcastIndex != -1) {
      if (currentPodcastIndex ==
          context.read<PodcastProvider>().podcast.length - 1) {
        play(context.read<PodcastProvider>().podcast.first);
      } else {
        play(context.read<PodcastProvider>().podcast[currentPodcastIndex + 1]);
      }
    }
  }

  void playPrevious(BuildContext context) {
    final currentPodcastIndex = context
        .read<PodcastProvider>()
        .podcast
        .indexWhere((element) => element.id == currentPodcastModel?.id);

    if (currentPodcastIndex != -1) {
      if (currentPodcastIndex == 0) {
        play(context.read<PodcastProvider>().podcast.last);
      } else {
        play(context.read<PodcastProvider>().podcast[currentPodcastIndex - 1]);
      }
    }
  }
}
