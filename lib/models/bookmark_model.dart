// To parse this JSON data, do
//
//     final bookmark = bookmarkFromJson(jsonString);

import 'dart:convert';

class Bookmark {
  Bookmark({
    this.newsId,
    this.time,
  });

  final String newsId;
  final String time;

  Bookmark copyWith({
    String newsId,
    String time,
  }) =>
      Bookmark(
        newsId: newsId ?? this.newsId,
        time: time ?? this.time,
      );

  factory Bookmark.fromRawJson(String str) =>
      Bookmark.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        newsId: json["newsId"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "newsId": newsId,
        "time": time,
      };
}
