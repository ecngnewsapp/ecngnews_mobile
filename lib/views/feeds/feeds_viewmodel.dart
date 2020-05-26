import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends BaseViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news;
  List<News> get appnews => _news;

  void listToNews() {
    setBusy(true);
    _newsService.listenToNewsInRealtime().listen((newsData) {
      List<News> updatedNews = newsData;
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Stream getMoreNews() async* {
    _newsService.requestNews();
  }
}
