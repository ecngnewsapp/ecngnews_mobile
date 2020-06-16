import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookmarkVeiw extends StatelessWidget {
  const BookmarkVeiw({Key key, this.userId}) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document('$userId')
          .collection('bookmarks')
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