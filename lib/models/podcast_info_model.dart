import 'package:audio_service/audio_service.dart';

import 'podcast_history_model.dart';
import 'author_model.dart';

class PodcastInfoModel {
  int? id;
  String? createdAt;
  String? url;
  String? title;
  String? subtitle;
  String? imgPath;
  int? authorId;
  AuthorModel? author;
  List<PodcastHistoryModel>? podcastHistory;

  PodcastInfoModel(
      {this.id,
      this.createdAt,
      this.url,
      this.title,
      this.subtitle,
      this.imgPath,
      this.authorId,
      this.author,
      this.podcastHistory});

  PodcastInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    url = json['url'];
    title = json['title'];
    subtitle = json['subtitle'];
    imgPath = json['img_path'];
    authorId = json['author_id'];
    author =
        json['author'] != null ? AuthorModel.fromJson(json['author']) : null;
    if (json['podcast_history'] != null) {
      podcastHistory = <PodcastHistoryModel>[];
      json['podcast_history'].forEach((v) {
        podcastHistory!.add(PodcastHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['url'] = url;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['img_path'] = imgPath;
    data['author_id'] = authorId;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (podcastHistory != null) {
      data['podcast_history'] = podcastHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  MediaItem get toMediaItem => MediaItem(
        id: url!,
        album: author?.name,
        title: title!,
        artist: author?.name,
        artUri: Uri.parse(imgPath!),
      );

  PodcastInfoModel copyWith({
    int? id,
    String? createdAt,
    String? url,
    String? title,
    String? subtitle,
    String? imgPath,
    int? authorId,
    AuthorModel? author,
    int? listened,
    List<PodcastHistoryModel>? podcastHistory,
  }) {
    return PodcastInfoModel(
      id: id ?? id,
      createdAt: createdAt ?? createdAt,
      url: url,
      title: title,
      subtitle: subtitle,
      imgPath: imgPath,
      author: author,
      authorId: authorId,
    );
  }
}
