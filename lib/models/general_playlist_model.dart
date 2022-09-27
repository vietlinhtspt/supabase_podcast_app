import 'podcast_info_model.dart';

class GeneralPlaylistModel {
  int? id;
  String? createdAt;
  int? podcastId;
  int? playlistId;
  PodcastInfoModel? podcastInfo;

  GeneralPlaylistModel(
      {this.id,
      this.createdAt,
      this.podcastId,
      this.playlistId,
      this.podcastInfo});

  GeneralPlaylistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    podcastId = json['podcast_id'];
    playlistId = json['playlist_id'];
    podcastInfo = json['podcast_info'] != null
        ? PodcastInfoModel.fromJson(json['podcast_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['podcast_id'] = podcastId;
    data['playlist_id'] = playlistId;
    if (podcastInfo != null) {
      data['podcast_info'] = podcastInfo!.toJson();
    }
    return data;
  }
}
