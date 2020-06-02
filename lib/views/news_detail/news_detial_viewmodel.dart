import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NewsDetialViewModel extends BaseViewModel {
  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
}
