class AuthorModel {
  int? id;
  String? createdAt;
  String? name;

  AuthorModel({this.id, this.createdAt, this.name});

  AuthorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['id'] = id;
    data['created_at'] = createdAt;
    data['name'] = name;
    return data;
  }
}
