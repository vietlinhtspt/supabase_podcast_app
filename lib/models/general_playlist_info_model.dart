import 'general_playlist_model.dart';

class GeneralPlaylistInfoModel {
  int? id;
  String? createdAt;
  String? title;
  String? subTitle;
  List<GeneralPlaylistModel>? generalPlaylist;

  GeneralPlaylistInfoModel({
    this.id,
    this.createdAt,
    this.title,
    this.subTitle,
    this.generalPlaylist,
  });

  GeneralPlaylistInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    title = json['title'];
    subTitle = json['sub_title'];
    if (json['general_playlist'] != null) {
      generalPlaylist = <GeneralPlaylistModel>[];
      json['general_playlist'].forEach((v) {
        generalPlaylist!.add(GeneralPlaylistModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['title'] = title;
    data['sub_title'] = subTitle;
    if (generalPlaylist != null) {
      data['general_playlist'] =
          generalPlaylist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
