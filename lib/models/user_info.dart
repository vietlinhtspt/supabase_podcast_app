import 'dart:convert';
import 'base_model.dart';

class UserInfo extends BaseModel {
  final int? id;
  final createdAt;
  final String? name;
  final String? email;
  final String? avatarPath;
  final bool? isDarkMode;
  UserInfo({
    this.id,
    this.createdAt,
    this.email,
    this.name,
    this.avatarPath,
    this.isDarkMode,
  });

  UserInfo copyWith({
    int? id,
    createdAt,
    String? name,
    String? email,
    String? avatarPath,
    bool? isDarkMode,
  }) {
    return UserInfo(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    if (id != null) {
      result.addAll({'id': id});
    }

    if (createdAt != null) {
      result.addAll({'created_at': createdAt});
    }

    if (avatarPath != null) {
      result.addAll({'avatar_path': avatarPath});
    }

    result.addAll({'name': name});
    result.addAll({'email': email});

    if (isDarkMode != null) {
      result.addAll({'is_dark_mode': isDarkMode});
    }

    return result;
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id']?.toInt(),
      createdAt: map['created_at'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatarPath: map['avatar_path'] ?? '',
      isDarkMode: map['is_dark_mode'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source));

  @override
  String toString() => toMap().toString();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfo && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
