import 'package:ecngnews/components/more_news_details.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_services/stacked_services.dart';

class NewsDetialViewModel extends StreamViewModel {
  bool _isAnonymous;
  bool get isAnonymous => _isAnonymous;
  bool _isNewsLiked = false;
  bool get isNewsLiked => _isNewsLiked;
  // AuthenticationService _authenticationService =
  //     locator<AuthenticationService>();
  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  News readNewsData = News();
  String newsContent;
  String newsSource;
  String _userId = '';
  get userId => _userId;
  Stream listenToNewsDetail(String newsId) async* {
    setBusy(true);
    _newsService.listenToNewsDetail(newsId).listen((event) {
      News update = event;
      if (update != null) {
        readNewsData = update
      }
    });
  }
  // NavigationService _navigationService = locator<NavigationService>();

  // Stre readNews(String newsId) async {
  //   print(userId);
  //   setBusy(true);
  //   readNewsData = await _newsService.readNews(newsId);
  //   if (readNewsData.content != null) {
  //     newsContent = readNewsData.content.split('[').first;
  //   } else {
  //     newsContent = 'this article has no news content';
  //   }
  //   if (readNewsData.source != null) {
  //     newsSource = readNewsData.source;
  //   } else {
  //     newsSource = 'Ecngnews App';
  //   }
  //   notifyListeners();
  //   setBusy(false);
  // }

  Future getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final result = await firebaseAuth.currentUser();
    _isAnonymous = result.isAnonymous;
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    print('gotten user ID: ' + result.uid);
    return result.uid;
  }

  Future<bool> isLiked(String userId, String newsId) async {
    String userId = await getUser();

    _isNewsLiked = await _newsService.ifNewsLiked(newsId, userId);
    notifyListeners();
    return _isNewsLiked;
  }

  Future like(String newsId) async {
    String userId = await getUser();
    if (!isAnonymous)
      await _newsService.likeNews(userId, newsId);
    else
      _dialogService
          .showDialog(
            title: 'only signined users can like',
            description: 'become a user to interact',
            confirmText: 'Ok',
          )
          .whenComplete(() => _navigationService
              .navigateWithTransition(WelcomeView(), transition: 'fade'));
  }

  void moreDetails(String newsPage) {
    _navigationService.navigateWithTransition(
        MoreNewsDetails(
          newsPage: newsPage,
        ),
        transition: 'fade');
  }

  @override
  // TODO: implement stream
  Stream get stream => throw UnimplementedError();
}
