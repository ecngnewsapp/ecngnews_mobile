import 'package:ecngnews/views/news_source_detial/news_source_detial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class NewsSourceDetialView extends StatelessWidget {
  const NewsSourceDetialView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsSourceDetialViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(),
        viewModelBuilder: () => NewsSourceDetialViewModel());
  }
}
