import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news;
  List<News> get appnews => _news;
  List<NewsCategory> _newsCategories;
  List<NewsCategory> get newsCategory => _newsCategories;
  // List<String> _categoryList = [
  //   'business',
  //   'entertainment',
  //   'general',
  //   'health',
  //   'science',
  //   'sports',
  //   'technology'
  // ];

  void setCategies() {}
  Stream listenToGeneralNews() async* {
    _newsService.listenToGeneralNews().listen((event) {
      List<News> updatedNews = event;
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
    });
  }

  Future setNewCategoryPan() async {
    _newsCategories = await _newsService.getCategory();
    notifyListeners();
  }

  void getMoreNews() => _newsService.requestMoreNews('general');
  // @override
  // Future futureToRun() => listToNews();

  @override
  Stream get stream => listenToGeneralNews();
}
