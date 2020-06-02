import 'package:ecngnews/views/news_detail/news_detial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewsDetailView extends StatelessWidget {
  final String newsId;
  const NewsDetailView({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsDetialViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(),
            ),
        viewModelBuilder: () => NewsDetialViewModel());
  }
}
