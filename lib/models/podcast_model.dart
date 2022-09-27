// import 'dart:convert';
// import 'package:audio_service/audio_service.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// import 'base_model.dart';

// class PodcastModel extends BaseModel {
//   @override
//   final int? id;
//   final String? createdAt;
//   final String? url;
//   final String? title;
//   final String? subtitle;
//   final String? imgPath;
//   final String? author;
//   final HistoryDetail? historyDetail;

//   PodcastModel({
//     this.id,
//     this.createdAt,
//     this.title,
//     this.url,
//     this.subtitle,
//     this.imgPath,
//     this.author,
//     this.historyDetail,
//   });

//   PodcastModel copyWith({
//     int? id,
//     String? createdAt,
//     String? url,
//     String? title,
//     String? subtitle,
//     bool? isDarkMode,
//     String? imgPath,
//     String? author,
//     HistoryDetail? historyDetail,
//   }) {
//     return PodcastModel(
//       id: id ?? this.id,
//       createdAt: createdAt ?? this.createdAt,
//       url: url ?? this.url,
//       title: title ?? this.title,
//       subtitle: subtitle ?? this.subtitle,
//       imgPath: imgPath ?? this.imgPath,
//       author: author ?? this.author,
//       historyDetail: historyDetail ?? this.historyDetail,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
//     if (id != null) {
//       result.addAll({'id': id});
//     }

//     if (createdAt != null) {
//       result.addAll({'created_at': createdAt});
//     }

//     result.addAll({
//       'url': url,
//       'title': title,
//       'subtitle': subtitle,
//       'img_path': imgPath,
//       'author': author,
//     });

//     return result;
//   }

//   factory PodcastModel.fromMap(Map<String, dynamic> map) {
//     return PodcastModel(
//         id: map['id']?.toInt(),
//         createdAt: map['created_at'],
//         url: map['url'],
//         title: map['title'],
//         subtitle: map['avatar_path'],
//         imgPath: map['img_path'],
//         historyDetail: map['podcast_history'] != null &&
//                 (map['podcast_history'] as List).isNotEmpty
//             ? HistoryDetail.fromMap((map['podcast_history'] as List).first)
//             : HistoryDetail(
//                 userEmail: Supabase.instance.client.auth.currentUser?.email,
//                 podcastId: map['id']?.toInt(),
//                 listened: 0,
//               ));
//   }

//   String toJson() => json.encode(toMap());

//   factory PodcastModel.fromJson(String source) =>
//       PodcastModel.fromMap(json.decode(source));

//   @override
//   String toString() => toMap().toString();

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is PodcastModel && other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;

//   MediaItem get toMediaItem => MediaItem(
//         id: url!,
//         album: author,
//         title: title!,
//         artist: author,
//         artUri: Uri.parse(imgPath!),
//       );
// }

// class HistoryDetail extends BaseModel {
//   @override
//   final int? id;
//   final createdAt;
//   final String? userEmail;
//   final int? podcastId;
//   final int? listened;

//   HistoryDetail({
//     this.id,
//     this.createdAt,
//     this.userEmail,
//     this.podcastId,
//     this.listened,
//   });

//   HistoryDetail copyWith({
//     int? id,
//     createdAt,
//     String? userEmail,
//     int? podcastId,
//     int? listened,
//   }) {
//     return HistoryDetail(
//       id: id ?? this.id,
//       createdAt: createdAt ?? this.createdAt,
//       userEmail: userEmail ?? this.userEmail,
//       podcastId: podcastId ?? this.podcastId,
//       listened: listened ?? this.listened,
//     );
//   }

//   @override
//   Map<String, dynamic> toMap() {
//     final result = <String, dynamic>{};
//     if (id != null && id != -1) {
//       result.addAll({'id': id});
//     }

//     if (createdAt != null) {
//       result.addAll({'created_at': createdAt});
//     }

//     result.addAll({
//       'user_email': userEmail,
//       'podcast_id': podcastId,
//       'listened': listened,
//     });

//     return result;
//   }

//   factory HistoryDetail.fromMap(Map<String, dynamic> map) {
//     return HistoryDetail(
//       id: map['id']?.toInt(),
//       createdAt: map['created_at'],
//       userEmail: map['user_email'],
//       podcastId: map['podcast_id'],
//       listened: map['listened'],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory HistoryDetail.fromJson(String source) =>
//       HistoryDetail.fromMap(json.decode(source));

//   @override
//   String toString() => toMap().toString();

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is HistoryDetail && other.id == id;
//   }

//   @override
//   int get hashCode => id.hashCode;
// }
