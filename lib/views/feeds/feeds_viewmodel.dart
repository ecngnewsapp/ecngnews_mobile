import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends BaseViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news = List<News>();
  List<News> get appnews => _news;
  List<NewsCategory> _newsCategories = List<NewsCategory>();
  List<NewsCategory> get newsCategory => _newsCategories;

  void listenToGeneralNews() {
    // setBusy(true);

    _newsService.listenToGeneralNews().listen((event) {
      List<News> updatedNews = event;
      print('value of updated news : ${updatedNews.length}');
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
      // setBusy(false);

      print('value of updated news : ${updatedNews.length}');
    });
  }

  // void getMoreNews() {
  //   print('get more news called');
  //   _newsService.requestMoreNews();
  // }

}
