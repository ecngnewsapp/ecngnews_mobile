// To parse this JSON data, do
//
//     final newsCategory = newsCategoryFromJson(jsonString);

import 'dart:convert';

//news cat
class NewsCategory {
  NewsCategory({
    this.categories,
    this.avatar,
  });

  final String categories;
  final String avatar;

  NewsCategory copyWith({
    String categories,
    String avatar,
  }) =>
      NewsCategory(
        categories: categories ?? this.categories,
        avatar: avatar ?? this.avatar,
      );

  factory NewsCategory.fromRawJson(String str) =>
      NewsCategory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsCategory.fromJson(Map<String, dynamic> json) => NewsCategory(
        categories: json["categories"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories,
        "avatar": avatar,
      };
}
