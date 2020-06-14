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
          int likes = snapshot.data.documents.length;

          return Text(
            likes < 1000
                ? '$likes'
                : likes > 1000 ? '1K+' : likes > 10000 ? '10K+' : '100K+',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
          );
        } else {
          return Text('0',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold));
        }
      },
    );
  }
}
