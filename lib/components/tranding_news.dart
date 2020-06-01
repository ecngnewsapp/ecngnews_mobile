import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class TrendingNews extends StatelessWidget {
  // final List<NewsModel> newsModel;

  const TrendingNews({
    Key key,
    // this.newsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return newsModel == null || newsModel.length < 3
    // ?
    // Container()
    // :
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: SizeConfig.h,
            width: SizeConfig.widthMultiplier * 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
//                    image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: NetworkImage(newsModel[0].urlToImage),
//                    ),
              borderRadius:
                  BorderRadius.all(Radius.circular(SizeConfig.sizeMultiplier)),
            ),
            child: Container(
              padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
//                    child: Text(
//                      newsModel[0].title,
//                      style: Theme.of(context).textTheme.body2.copyWith(
//                          color: Colors.white, fontWeight: FontWeight.bold),
//                    ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          Container(
            width: SizeConfig.widthMultiplier * 48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: SizeConfig.heightMultiplier * 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
//                          image: DecorationImage(
//                            fit: BoxFit.cover,
//                            image: NetworkImage(newsModel[1].urlToImage),
//                          ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.sizeMultiplier),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
//                          child: Text(
//                            newsModel[1].title,
//                            style: Theme.of(context).textTheme.body2.copyWith(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                          ),
                    alignment: Alignment.bottomLeft,
                  ),
                ),
                Container(
                  height: SizeConfig.heightMultiplier * 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    image: DecorationImage(
                      fit: BoxFit.cover, image: null,
//                            image: NetworkImage(newsModel[2].urlToImage),
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.sizeMultiplier)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
//                          child: Text(
//                            newsModel[2].title,
//                            style: Theme.of(context).textTheme.body2.copyWith(
//                                color: Colors.white,
//                                fontWeight: FontWeight.bold),
//                          ),
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
      height: SizeConfig.heightMultiplier * 22,
      decoration: EcngTheme.cardDecoration,
    );
  }
}
