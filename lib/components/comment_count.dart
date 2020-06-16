import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentCount extends StatelessWidget {
  final newsId;
  final Color textColor;
  const CommentCount({
    Key key,
    this.newsId,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('contents')
          .document('$newsId')
          .collection('comments')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          int comments = snapshot.data.documents.length;

          return Text(
            comments < 1000
                ? '$comments'
                : comments > 1000 ? '1K+' : comments > 10000 ? '10K+' : '100K+',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontSize: 14, fontWeight: FontWeight.bold, color: textColor),
          );
        } else {
          return Text('0',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontSize: 14, fontWeight: FontWeight.bold, color: textColor));
        }
      },
    );
  }
}
