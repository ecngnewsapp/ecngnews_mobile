import 'package:ecngnews/components/news_card_item.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class LatestNewsCard extends StatelessWidget {
  // final NewsModel newsItem1;
  // final NewsModel newsItem2;

  const LatestNewsCard({
    Key key,
    // this.newsItem1,
    // this.newsItem2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.sizeMultiplier * 2)),
              boxShadow: [
                BoxShadow(
                    color: EcngColors.shadowColor,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 2))
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Container(
//                  child: Text(
//                    newsItem1.title,
//                    style: Theme.of(context).textTheme.subhead,
//                  ),
//                  padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
//                ),
//                Container(
//                  height: SizeConfig.heightMultiplier * 20,
//                  width: SizeConfig.w,
//                  decoration: BoxDecoration(
//                    color: EcngColors.primaryColor,
//                    borderRadius: BorderRadius.all(
//                        Radius.circular(SizeConfig.sizeMultiplier * 2)),
//                    image: DecorationImage(
//                        fit: BoxFit.cover,
//                        image: newsItem1.urlToImage != null &&
//                                newsItem1.urlToImage.isNotEmpty
//                            ? NetworkImage(newsItem1.urlToImage)
//                            : AssetImage(EcngAssets.logo)),
//                  ),
//                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 1.6,
          ),
          NewsItemCard(
              // news: newsItem2,
              ),
        ],
      ),
    );
  }
}
