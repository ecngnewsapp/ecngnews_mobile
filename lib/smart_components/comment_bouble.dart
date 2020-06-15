import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class CommentBobble extends StatelessWidget {
  final Comments comment;
  const CommentBobble({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        TimeOfDay.fromDateTime(DateTime.parse(comment.time)).format(context);
    return Container(
      margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundColor: EcngColors.primaryColor,
          ),
          Container(
            width: SizeConfig.widthMultiplier * 50,
            decoration: BoxDecoration(
              color: EcngColors.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.sizeMultiplier * 2),
                topRight: Radius.circular(SizeConfig.sizeMultiplier * 2),
                bottomRight: Radius.circular(SizeConfig.sizeMultiplier * 2),
              ),
            ),
            padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
            child: Text('${comment.comment}'),
          ),
          Container(
            width: SizeConfig.widthMultiplier * 14,
            child: Text(
              '$time',
              softWrap: true,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
