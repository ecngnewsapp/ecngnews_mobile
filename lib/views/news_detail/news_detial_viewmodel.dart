import 'package:ecngnews/components/more_news_details.dart';
import 'package:ecngnews/models/like_model.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/views/comment/comments_view.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
// import 'package:stacked_services/stacked_services.dart';

class NewsDetialViewModel extends BaseViewModel {
  bool _isAnonymous;
  bool get isAnonymous => _isAnonymous;
  bool _isNewsLiked = false;
  bool get isNewsLiked => _isNewsLiked;

  NewsService _newsService = locator<NewsService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  News readNewsData = News();
  String newsContent;
  String newsSource;
  String _userId = '';
  get userId => _userId;
  List<LikeModel> _likes = List<LikeModel>();
  List<LikeModel> get likes => _likes;
  // NavigationService _navigationService = locator<NavigationService>();
  Stream listenToLikes(String newsId) async* {
    setBusy(true);

    _newsService.listenToLikes(newsId).listen((event) {
      List<LikeModel> update = event;
      print('listen to likes called');
      if (update != null) {
        _likes = update;
        notifyListeners();
        setBusy(false);
      }
    });
  }

  Future readNews(String newsId) async {
    print(userId);
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

  Future getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final result = await firebaseAuth.currentUser();
    _isAnonymous = result.isAnonymous;
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    print(result.uid);
    return result.uid;
  }

  Future<bool> isLiked(String newsId) async {
    String userId = await getUser();
    _isNewsLiked = await _newsService.ifNewsLiked(newsId, userId);
    notifyListeners();
    return _isNewsLiked;
  }

  Future like(String newsId) async {
    String userId = await getUser();
    if (!isAnonymous) {
      await _newsService.likeNews(userId, newsId);
      isLiked(newsId);
    } else
      _dialogService
          .showDialog(
            title: 'only signined users can like',
            description: 'become a user to interact',
            confirmText: 'Ok',
          )
          .whenComplete(() => _navigationService
              .navigateWithTransition(WelcomeView(), transition: 'fade'));
    notifyListeners();
  }

  Future bookmark(String newsId) async {}

  Future comment(String newsId) async {
    String userId = await getUser();
    if (!isAnonymous) {
      _navigationService.navigateWithTransition(
        CommentView(
          userId: userId,
          newsId: newsId,
        ),
        transition: 'downTotop',
      );
    } else
      _dialogService
          .showDialog(
            title: 'only signined users can like',
            description: 'become a user to interact',
            confirmText: 'Ok',
          )
          .whenComplete(() => _navigationService
              .navigateWithTransition(WelcomeView(), transition: 'fade'));
    notifyListeners();
  }

  void moreDetails(String newsPage) {
    _navigationService.navigateWithTransition(
        MoreNewsDetails(
          newsPage: newsPage,
        ),
        transition: 'fade');
  }
}
