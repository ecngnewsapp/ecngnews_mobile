import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news;
  List<News> get appnews => _news;
  List<String> _categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  List<String> get categoriesList => _categories;
  Stream listenToNews() async* {
    _newsService.listenToGeneralNews().listen((event) {
      List<News> updatedNews = event;
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
    });
  }

  void getMoreNews() => _newsService.requestMoreNews('general');
  // @override
  // Future futureToRun() => listToNews();

  @override
  Stream get stream => listenToNews();
}
