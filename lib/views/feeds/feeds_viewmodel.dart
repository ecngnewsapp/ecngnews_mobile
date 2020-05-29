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

  Stream listenToGeneralNews() async* {
    _newsService.listenToGeneralNews().listen((event) {
      List<News> updatedNews = event;
      print('value of updated news : ${updatedNews.length}');
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        // notifyListeners();
      } else {}
      // setBusy(false);

      print('value of updated news : ${updatedNews.length}');
    });
  }

  void refesh() async {
    _newsService.referesh();
    notifyListeners();
  }

  Future setNewCategoryPan() async {
    _newsCategories = await _newsService.getCategory();
    print('printing ');
    notifyListeners();
    return _newsCategories;
  }

  void getMoreNews() {
    _newsService.requestMoreNews('general');
  }

  @override
  Stream get stream => listenToGeneralNews();
}

// _newsService.listenToGeneralNews().listen((event) {
//       List<News> updatedNews = event;
//       print('value of updated news : ${updatedNews.length}');
//       if (updatedNews != null && updatedNews.length > 0) {
//         _news = updatedNews;
//         notifyListeners();
//       }
//       print('value of updated news : ${updatedNews.length}');
//     });
