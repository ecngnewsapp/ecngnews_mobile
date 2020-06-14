import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikeStream extends StatelessWidget {
  final String newsId;
  const LikeStream({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('contents')
          .document('$newsId')
          .collection('likes')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data.documents.length}');
        } else {
          return Text('0');
        }
      },
    );
  }
}
