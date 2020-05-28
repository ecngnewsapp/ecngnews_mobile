import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news;
  List<News> get appnews => _news;

  Stream listenToNews() async* {
    _newsService.listenToNews().listen((event) {
      List<News> updatedNews = event;
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
    });
  }

  void getMoreNews() => _newsService.requestMoreNews();
  // @override
  // Future futureToRun() => listToNews();

  @override
  Stream get stream => listenToNews();
}
