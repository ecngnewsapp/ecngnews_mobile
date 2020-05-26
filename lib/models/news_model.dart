// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

class News {
  final String author;
  final String category;
  final String contentType;
  final String date;
  final String description;
  final String imageUrl;
  final int loves;
  final String source;
  final String timestamp;
  final String title;
  final String url;

  News({
    this.author,
    this.category,
    this.contentType,
    this.date,
    this.description,
    this.imageUrl,
    this.loves,
    this.source,
    this.timestamp,
    this.title,
    this.url,
  });

  News copyWith({
    String author,
    String category,
    String contentType,
    String date,
    String description,
    String imageUrl,
    int loves,
    String source,
    String timestamp,
    String title,
    String url,
  }) =>
      News(
        author: author ?? this.author,
        category: category ?? this.category,
        contentType: contentType ?? this.contentType,
        date: date ?? this.date,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        loves: loves ?? this.loves,
        source: source ?? this.source,
        timestamp: timestamp ?? this.timestamp,
        title: title ?? this.title,
        url: url ?? this.url,
      );

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
        author: json["author"],
        category: json["category"],
        contentType: json["content type"],
        date: json["date"],
        description: json["description"],
        imageUrl: json["image url"],
        loves: json["loves"],
        source: json["source"],
        timestamp: json["timestamp"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "category": category,
        "content type": contentType,
        "date": date,
        "description": description,
        "image url": imageUrl,
        "loves": loves,
        "source": source,
        "timestamp": timestamp,
        "title": title,
        "url": url,
      };
}
