import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class CommentStream extends StatelessWidget {
  final String newsId;
  const CommentStream({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier),
        color: EcngColors.defaultIconColor,
        boxShadow: EcngColors.cardBoxShadow,
      ),
      child: Row(
        children: [
          Text(
            '0',
            style: TextStyle(color: Colors.white),
          ),
          Text(
            ' comments',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
