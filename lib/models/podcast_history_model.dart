import 'dart:convert';

import 'base_model.dart';

class PodcastHistoryModel extends BaseModel {
  @override
  final int? id;
  final String? createdAt;
  final String? userEmail;
  final int? podcastId;
  final int? listened;

  PodcastHistoryModel({
    this.id,
    this.createdAt,
    this.userEmail,
    this.podcastId,
    this.listened,
  });

  PodcastHistoryModel copyWith({
    int? id,
    String? createdAt,
    String? userEmail,
    int? podcastId,
    int? listened,
  }) {
    return PodcastHistoryModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userEmail: userEmail ?? this.userEmail,
      podcastId: podcastId ?? this.podcastId,
      listened: listened ?? this.listened,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (id != null && id != -1) {
      result.addAll({'id': id});
    }

    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }

    result.addAll({
      'user_email': userEmail,
      'podcast_id': podcastId,
      'listened': listened,
    });

    return result;
  }

  factory PodcastHistoryModel.fromMap(Map<String, dynamic> map) {
    return PodcastHistoryModel(
      id: map['id']?.toInt(),
      createdAt: map['created_at'],
      userEmail: map['user_email'],
      podcastId: map['podcast_id'],
      listened: map['listened'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PodcastHistoryModel.fromJson(Map<String, dynamic> source) =>
      PodcastHistoryModel.fromMap(source);

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PodcastHistoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
