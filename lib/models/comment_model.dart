// To parse this JSON data, do
//
//     final comments = commentsFromJson(jsonString);

import 'dart:convert';

class Comments {
  Comments({
    this.owner,
    this.comment,
    this.time,
    this.file,
  });
//keys
  final String owner;
  final String comment;
  final String time;
  final String file;

  Comments copyWith({
    String owner,
    String comment,
    String time,
    String file,
  }) =>
      Comments(
        owner: owner ?? this.owner,
        comment: comment ?? this.comment,
        time: time ?? this.time,
        file: file ?? this.file,
      );

  factory Comments.fromRawJson(String str) =>
      Comments.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        owner: json["owner"],
        comment: json["comment"],
        time: json["time"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "comment": comment,
        "time": time,
        "file": file,
      };
}
