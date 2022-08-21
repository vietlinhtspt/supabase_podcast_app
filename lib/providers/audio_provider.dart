import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

import '../models/podcast_model.dart';

class AudioProvider extends ChangeNotifier {
  late AudioHandler _audioHandler;
  bool isMaximumSize = false;
  PodcastModel? _currentPodcastModel;

  AudioProvider({required AudioHandler audioHandler}) {
    _audioHandler = audioHandler;
  }

  AudioHandler get audioHandler => _audioHandler;
  PodcastModel? get currentPodcastModel => _currentPodcastModel;

  void showMaximumPlayer() {
    isMaximumSize = true;
    notifyListeners();
  }

  void play(PodcastModel newPodcastModel) {
    _currentPodcastModel = newPodcastModel;
    if (_currentPodcastModel != null) {
      _audioHandler.playMediaItem(_currentPodcastModel!.toMediaItem);
    }

    isMaximumSize = true;
    notifyListeners();
  }

  // Future

}
