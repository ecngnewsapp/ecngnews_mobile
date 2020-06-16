import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CommentsViewModel extends StreamViewModel {
  final String newsID;
  String _userId;
  String get userId => _userId;
  NewsService _newsService = locator<NewsService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  List<Comments> _comments = List<Comments>();
  List<Comments> get comments => _comments;
  CommentsViewModel(this.newsID);

  Stream listentToComments(newsID) async* {
    _newsService.listenToComment(newsID).listen((event) {
      var updates = event;
      if (updates != null) {
        _comments = updates;
        notifyListeners();
      }
    });
  }

  bool _isAnonymous = false;
  Future<String> getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final result = await firebaseAuth.currentUser();

    _isAnonymous = result.isAnonymous;
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    _userId = result.uid;
    notifyListeners();
    print(result.uid);
    return result.uid;
  }

  Future sendComment(String newsId, String comment) async {
    print(newsId);
    String userId = await getUser();
    if (!_isAnonymous) {
      await _newsService.commentOnNews(userId, newsId, comment);
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

  @override
  Stream get stream => listentToComments(newsID);
}
