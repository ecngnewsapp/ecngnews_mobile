import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class FeedViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  List<News> _news = List<News>();
  List<News> get appnews => _news;
  List<NewsCategory> _newsCategories = List<NewsCategory>();
  List<NewsCategory> get newsCategory => _newsCategories;
  // Stream _newsSource;
  int _sourceIndex = 0;
  void setSource(int _source) {
    setBusy(true);
    print('set source called on $_source');
    _sourceIndex = _source;
    print('news source index $_sourceIndex');
    notifySourceChanged();
    setBusy(false);
  }

  Stream listenToNewsByCategory(String category) async* {
    _newsService.listenToNews(category).listen((event) {
      List<News> updatedNews = event;
      print('value of updated news : ${updatedNews.length}');
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
      print('value of updated news : ${updatedNews.length}');
    });
  }

  void viewDetail() {}

  Future setNewCategoryPan() async {
    _newsCategories = await _newsService.getCategory();
    notifyListeners();
    return _newsCategories;
  }

  void referesh() {
    _newsService.referesh('general');
  }

  @override
  Stream get stream => _sourceIndex == 0
      ? listenToNewsByCategory('general')
      : _sourceIndex == 1
          ? listenToNewsByCategory('sports')
          : _sourceIndex == 2
              ? listenToNewsByCategory('business')
              : _sourceIndex == 3
                  ? listenToNewsByCategory('entertainment')
                  : _sourceIndex == 4
                      ? listenToNewsByCategory('health')
                      : _sourceIndex == 5
                          ? listenToNewsByCategory('science')
                          : listenToNewsByCategory('technology');
}
