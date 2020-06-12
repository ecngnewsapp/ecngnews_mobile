import 'package:ecngnews/components/more_news_details.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_services/stacked_services.dart';

class NewsDetialViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  News readNewsData = News();
  String newsContent;
  String newsSource;
  // NavigationService _navigationService = locator<NavigationService>();
  Future readNews(String newsId) async {
    setBusy(true);
    readNewsData = await _newsService.readNews(newsId);
    if (readNewsData.content != null) {
      newsContent = readNewsData.content.split('[').first;
    } else {
      newsContent = 'this article has no news content';
    }
    if (readNewsData.source != null) {
      newsSource = readNewsData.source;
    } else {
      newsSource = 'Ecngnews App';
    }
    notifyListeners();
    setBusy(false);
  }

  Future like(String userId, String newsId) async {
    bool isAnonymous;

    if (await _authenticationService.checkUserAnonymous())
      await _newsService.likeNews(userId, newsId);
    else
      _dialogService.showDialog();
  }

  void moreDetails(String newsPage) {
    _navigationService.navigateWithTransition(
        MoreNewsDetails(
          newsPage: newsPage,
        ),
        transition: 'fade');
  }
}
