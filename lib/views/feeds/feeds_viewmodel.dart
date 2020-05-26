import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> get sportNews => data;

  Stream getNews() async* {
    yield* _newsService.getSportNews('sports');
  }

  @override
  Stream get stream => getNews();
}
