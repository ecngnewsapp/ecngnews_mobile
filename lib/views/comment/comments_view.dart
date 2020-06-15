import 'package:ecngnews/views/comment/comments_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CommentView extends StatelessWidget {
  final String newsId, userId;
  const CommentView({Key key, this.newsId, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold();
        },
        viewModelBuilder: () => CommentsViewModel());
  }
}
