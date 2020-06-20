import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/views/news_detail/news_detial_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends StreamViewModel {
  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<News> _news = List<News>();
  List<News> get appnews => _news;

  Stream listenToNewsSearch(String searchString) async* {
    _newsService.listenToNewsSearch(searchString).listen((event) {
      print('search Invocked form model');
      List<News> updatedNews = event;
      print('value of updated news : ${updatedNews.length}');
      if (updatedNews != null && updatedNews.length > 0) {
        _news = updatedNews;
        notifyListeners();
      }
      print('value of updated news : ${updatedNews.length}');
      print('first Video url ${_news[0].url}');
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

  Future search(String searchString) async {
    _newsService.searchNews(searchString);
    notifyListeners();
  }

  @override
  Stream get stream => listenToNewsSearch('');
}
