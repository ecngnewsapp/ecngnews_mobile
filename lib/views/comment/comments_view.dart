import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/smart_components/comment_bouble.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/comment/comments_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

class CommentView extends StatefulWidget {
  final String newsId, userId;
  const CommentView({Key key, this.newsId, this.userId}) : super(key: key);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommentsViewModel>.reactive(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: EcngColors.primaryColor,
            appBar: AppBar(
              elevation: 0,
              title: Text('Comments'),
            ),
            body: Stack(
              children: [
                //Comments
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(SizeConfig.sizeMultiplier * 4))),
                  margin: EdgeInsets.only(
                      top: SizeConfig.sizeMultiplier,
                      bottom: SizeConfig.heightMultiplier * 10),
                  padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                  child: model.comments.isEmpty || model.comments == null
                      ? Container()
                      : ListView.builder(
                          reverse: true,
                          itemCount: model.comments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child:
                                  CommentBobble(comment: model.comments[index]),
                            );
                          },
                        ),
                ),
                //comment box
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                    decoration: BoxDecoration(color: Colors.white),
                    child: TextField(
                      controller: _controller,
                      autocorrect: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      cursorColor: EcngColors.primaryColor,
                      decoration: InputDecoration(
                          prefixIcon: Icon(MaterialCommunityIcons.paperclip),
                          suffixIcon: IconButton(
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.send,
                              ),
                              onPressed: () {
                                model.sendComment(
                                    widget.newsId, _controller.text);
                                _controller.clear();
                              }),
                          filled: true,
                          fillColor: EcngColors.primaryColor.withOpacity(.1),
                          hintText: 'Type a comment',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.sizeMultiplier * 10),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => CommentsViewModel(widget.newsId));
  }
}
