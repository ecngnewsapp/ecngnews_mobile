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
      height: SizeConfig.heightMultiplier * 14,
      margin: EdgeInsets.symmetric(
          vertical: SizeConfig.sizeMultiplier * .8,
          horizontal: SizeConfig.sizeMultiplier),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.sizeMultiplier * 2),
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
                  fit: BoxFit.fill,
                  image: news.imageUrl != null && news.imageUrl.isNotEmpty
                      ? NetworkImage(news.imageUrl)
                      : AssetImage(EcngAssets.logo)),
              borderRadius: BorderRadius.all(
                Radius.circular(SizeConfig.sizeMultiplier * 2),
              ),
            ),
            width: SizeConfig.widthMultiplier * 40,
          ),
          Container(
            padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
            width: SizeConfig.widthMultiplier * 40,
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
        ],
      ),
    );
  }
}
