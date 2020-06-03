import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

class NewsDetialViewModel extends BaseViewModel {
  NewsService _newsService = locator<NewsService>();
  News readNewsData = News();
  // NavigationService _navigationService = locator<NavigationService>();
  Future readNews(String newsId) async {
    readNewsData = await _newsService.readNews(newsId);
    notifyListeners();
  }
}
