import 'package:ecngnews/models/like_model.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/views/news_detail/news_detial_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FeedViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<News> _news = List<News>();
  List<LikeModel> _likes = List<LikeModel>();
  List<LikeModel> get likes => _likes;
  List<News> get appnews => _news;
  List<NewsCategory> _newsCategories = List<NewsCategory>();
  List<NewsCategory> get newsCategory => _newsCategories;
  // Stream _newsSource;
  String _sourceIndex = 'general';
  void setSource(String _source) {
    setBusy(true);
    print('set source called on $_source');
    _sourceIndex = _source;
    print('news source index $_sourceIndex');
    notifySourceChanged();
    setBusy(false);
  }

  Stream listenToNewsByCategory(String category) async* {
    // setBusy(true);
    _newsService.listenToNews(category).listen((event) {
      List<News> updatedNews = event;
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;

        // notifyListeners();
        // setBusy(false);
      }
      print('value of updated news : ${updatedNews.length}');
    });
  }

  void viewDetails(String newsId) {
    _navigationService.navigateWithTransition(
      NewsDetailView(
        newsId: newsId,
      ),
      transition: 'downToTop',
    );
  }

  Future setNewCategoryPan() async {
    setBusy(true);
    _newsCategories = await _newsService.getCategory();
    notifyListeners();
    setBusy(false);
    return _newsCategories;
  }

  // void referesh() {
  //   _newsService.referesh('general');
  // }

  @override
  Stream get stream => _sourceIndex == 'general'
      ? listenToNewsByCategory('general')
      : _sourceIndex == 'sports'
          ? listenToNewsByCategory('sports')
          : _sourceIndex == 'business'
              ? listenToNewsByCategory('business')
              : _sourceIndex == 'entertainment'
                  ? listenToNewsByCategory('entertainment')
                  : _sourceIndex == 'health'
                      ? listenToNewsByCategory('health')
                      : _sourceIndex == 'science'
                          ? listenToNewsByCategory('science')
                          : listenToNewsByCategory('technology');
}
