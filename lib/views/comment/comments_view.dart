import 'dart:math';

import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/comment/comments_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
            body: Container(
              child: Stack(
                children: [
                  //Comments
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: SizeConfig.heightMultiplier * 85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(SizeConfig.sizeMultiplier * 5),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                        height: SizeConfig.h,
                        child: ListView.builder(
                          itemCount: model.comments.length,
                          itemBuilder: (context, index) {
                            return Container(
                              child: Text(model.comments[index].comment),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  //comment box
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                      decoration: BoxDecoration(
                          // color: EcngColors.primaryColor.withOpacity(.1),
                          ),
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
            ),
          );
        },
        viewModelBuilder: () => CommentsViewModel(widget.newsId));
  }
}
