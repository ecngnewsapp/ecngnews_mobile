import 'package:ecngnews/components/comment_count.dart';
import 'package:ecngnews/components/like_stream.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class NewsItemCard extends StatelessWidget {
  final News news;
  const NewsItemCard({
    Key key,
    this.news,
    // this.news,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 24,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.sizeMultiplier * .8,
          horizontal: SizeConfig.sizeMultiplier),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.sizeMultiplier),
          ),
          boxShadow: [
            BoxShadow(
              color: EcngColors.shadowColor,
              offset: Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: news.imageUrl != null && news.imageUrl.isNotEmpty
                      ? NetworkImage('${news.imageUrl}')
                      : AssetImage(EcngAssets.logo)),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(SizeConfig.sizeMultiplier),
              ),
            ),
            width: SizeConfig.widthMultiplier * 30,
          ),
          Container(
            padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.widthMultiplier * 60,
                  height: SizeConfig.heightMultiplier * 10,
                  child: Text(
                    news.title,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.sizeMultiplier * 1.2,
                    vertical: SizeConfig.sizeMultiplier * .5,
                  ),
                  child: Text(
                    '${news.category}',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  decoration: BoxDecoration(
                      color: EcngColors.defaultIconColor,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(SizeConfig.sizeMultiplier * 2),
                        right: Radius.circular(SizeConfig.sizeMultiplier * 2),
                      )),
                ),
                Divider(
                  color: EcngColors.primaryColor,
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 60,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //likes
                      Row(
                        children: [
                          LikeStream(
                            newsId: news.timestamp,
                          ),
                          Text('likes'),
                        ],
                      ),
                      Row(
                        children: [
                          CommentCount(
                            newsId: news.timestamp,
                            textColor: Colors.black,
                          ),
                          Text('comments'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
