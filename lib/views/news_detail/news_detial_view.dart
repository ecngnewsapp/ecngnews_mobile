import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/news_detail/news_detial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewsDetailView extends StatelessWidget {
  final String newsId;
  const NewsDetailView({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsDetialViewModel>.reactive(
        onModelReady: (m) => m.readNews(newsId),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: [
                  Container(
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
                                image: '${model.readNewsData.imageUrl}'),
                          ),
                        ),
                        //Text
                        VerticalSpacer(),
                        Container(
                          child: Text(
                            '${model.readNewsData.title}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => NewsDetialViewModel());
  }
}
