import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/news_detail/news_detial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class NewsDetailView extends StatelessWidget {
  final String newsId;
  const NewsDetailView({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsDetialViewModel>.reactive(
        onModelReady: (m) {
          m.readNews(newsId);
        },
        builder: (context, model, child) {
          News news = News();
          news = model.readNewsData;

          return Scaffold(
            appBar: AppBar(),
            body: model.isBusy
                ? ListTileShimmer()
                : ListView(
                    children: [
                      // title and image
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: EcngColors.cardBoxShadow,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.sizeMultiplier * 1.5)),
                        margin: EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
                        //image and text
                        child: Column(
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.sizeMultiplier * 1.5),
                                child: FadeInImage.assetNetwork(
                                    placeholder: 'Loading',
                                    image: '${news.imageUrl}'),
                              ),
                            ),
                            //Text
                            VerticalSpacer(
                              space: .2,
                            ),
                            Container(
                              margin: EdgeInsets.all(
                                  SizeConfig.sizeMultiplier * 1.5),
                              child: Text(
                                '${news.title}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //like and bookmark
                      Container(
                        padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //news time
                            Container(
                              width: SizeConfig.widthMultiplier * 30,
                              //news time
                              child: Text(
                                '${model.readNewsData.date}',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 10),
                              ),
                            ),
                            //like commint
                            Container(
                              width: SizeConfig.widthMultiplier * 20,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.sizeMultiplier * .5),
                                    child: Icon(Icons.bookmark_border),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(.10),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.sizeMultiplier * .5),
                                    child: Icon(
                                        MaterialCommunityIcons.heart_outline),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.withOpacity(.10),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: EcngColors.cardBoxShadow,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                SizeConfig.sizeMultiplier)),
                        padding:
                            EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
                        margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            //all text
                            Container(
                              child: Column(
                                children: [
                                  //decription
                                  Container(
                                    child: Text(
                                      '${news.description}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  VerticalSpacer(),
                                  Container(
                                    child: Text('${model.newsContent}'),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: -16,
                              right: -SizeConfig.widthMultiplier,
                              child: GestureDetector(
                                onTap: () => model
                                    .moreDetails('${model.readNewsData.url}'),
                                child: Container(
                                  padding:
                                      EdgeInsets.all(SizeConfig.sizeMultiplier),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      SizeConfig.sizeMultiplier,
                                    ),
                                    color: EcngColors.primaryColor,
                                  ),
                                  child: Text(
                                    'more',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'News source',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: EcngColors.primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                '${model.newsSource}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: EcngColors.defaultIconColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        },
        viewModelBuilder: () => NewsDetialViewModel());
  }
}
