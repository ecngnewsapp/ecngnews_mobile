import 'package:ecngnews/models/like_model.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:stacked/stacked.dart';

class LikesComponentViewModel extends StreamViewModel {
  final String newsID;
  NewsService _newsService = locator<NewsService>();
  List<LikeModel> _likes = List<LikeModel>();

  LikesComponentViewModel(this.newsID);
  List<LikeModel> get likes => _likes;

  void justPrint() {
    print('printed just print');
  }

  Stream listenToLikes(String newsId) async* {
    setBusy(true);
    print('called');
    _newsService.listenToLikes(newsId).listen((event) {
      List<LikeModel> updates = event;
      if (updates != null) {
        _likes = updates;
        notifyListeners();
        setBusy(false);
      }

      print("gotten likes: " + likes.toString());

      print('listen to likes called');
    });
  }

  @override
  Stream get stream => listenToLikes(newsID);
}
