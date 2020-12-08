// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

class Album {
  Album({
    this.userId,
    this.id,
    this.title,
  });

  int userId;
  int id;
  String title;

  Album copyWith({
    int userId,
    int id,
    String title,
  }) =>
      Album(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        title: title ?? this.title,
      );

  factory Album.fromRawJson(String str) => Album.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
