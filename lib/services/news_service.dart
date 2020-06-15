import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/models/like_model.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');

  // List<List<News>> _allPagedNewsResults = List<List<News>>();

  static const int PostsLimit = 20;

  // DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  bool get hasMorsPost => _hasMorePosts;
  //news Stream controller
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  //likes stream controller
  final StreamController<List<LikeModel>> _likesStreamController =
      StreamController<List<LikeModel>>.broadcast();
  //videows stream controller
  final StreamController<List<News>> _newsVideoStreamController =
      StreamController<List<News>>.broadcast();
  //search stream controller
  final StreamController<List<News>> _newsSearchStreamController =
      StreamController<List<News>>.broadcast();

  Stream<dynamic> listenToNews(String category) async* {
    _requestNews(category);
    yield* _newsStreamController.stream;
  }

  Stream<dynamic> listenToNewsVideos() async* {
    _requestVideoNews();
    yield* _newsVideoStreamController.stream;
  }

  Stream<dynamic> listenToLikes(String newsId) async* {
    print('list to likes called');
    getLiveLikesFor(newsId);
    yield* _likesStreamController.stream;
  }

  void getLiveLikesFor(String newsId) {
    List<LikeModel> likes = List<LikeModel>();

    _newsCollectionReference
        .document('$newsId')
        .collection('likes')
        .orderBy('id')
        .snapshots()
        .listen((event) {
      likes = event.documents.map((e) => LikeModel.fromJson(e.data)).toList();
      _likesStreamController.add(likes);
    });

    print('likes from service ${likes.length}');
  }

  String getLikes(String newsId) {
    int ilike = 0;
    _newsCollectionReference
        .document('$newsId')
        .collection('likes')
        .snapshots()
        .length;
    // .then((value) => likes = value.documents.length);

    print('likes from service $ilike');
    return ilike.toString();
  }

  Future _requestNews(String category) async {
    var pagePostsQuery = _newsCollectionReference
        .where('category', isEqualTo: '$category')
        .orderBy('timestamp', descending: true)
        .limit(PostsLimit);

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents.map((snapshot) {
          var news = News.fromJson(snapshot.data);
          print('news loves ${news.loves}');
          return news;
        }).toList();

        _newsStreamController.add(posts);
      }
    });
  }

  Future readNews(String newsId) {
    print('news id' + newsId);
    Future<News> readNews = _newsCollectionReference
        .document(newsId)
        .get()
        .then((value) => News.fromJson(value.data));
    return readNews;
  }

  Future likeNews(String userId, String newsId) async {
    print('user id ' + userId);
    var _likeRef =
        _newsCollectionReference.document('$newsId').collection('likes');
    var data = LikeModel(userId: userId).toJson();
    _likeRef.document('$userId').setData(data);
    return 'sucesss';
  }

  Future<bool> ifNewsLiked(String newsId, String userId) async {
    print('user id and news id: $userId, $newsId');
    return _newsCollectionReference
        .document('$newsId')
        .collection('likes')
        .document('$userId')
        .get()
        .then((value) => value.exists);
  }

  Future commentOnNews(String userId, String newsId) async {
    var _commentRef =
        _newsCollectionReference.document('$newsId').collection('comments');
    var data = Comments(owner: userId).toJson();
    _commentRef.document('$newsId').setData(data);
    return 'success';
  }

//listining to news search
  Stream<dynamic> listenToNewsSearch(String searchString) async* {
    searchNews(searchString);
    yield* _newsSearchStreamController.stream;
  }

  Future<List<NewsCategory>> getCategory() async {
    List<String> categoriesStrings = [
      "general",
      "sports",
      "business",
      "entertainment",
      "health",
      "science",
      "technology",
    ];
    List<NewsCategory> categories = List<NewsCategory>();
    categoriesStrings.forEach((element) {
      var catQuery = _newsCollectionReference
          .where('category', isEqualTo: element)
          .orderBy('timestamp', descending: true)
          .limit(1);

      catQuery.snapshots().listen((event) {
        var newsDoc =
            event.documents.map((e) => News.fromJson(e.data)).toList();
        categories.add(
          NewsCategory(
            categories: newsDoc[0].category,
            avatar: newsDoc[0].imageUrl,
          ),
        );
      });
    });

    return categories;
  }

  void searchNews(String searchString) {
    print('searchingfor $searchString');
    var pagePostsQuery = _newsCollectionReference
        .where('titleIndex', arrayContains: searchString)
        .limit(10);

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => News.fromJson(snapshot.data))
            .toList();

        _newsSearchStreamController.add(posts);
      }
    });
  }

  void _requestVideoNews() {
    var pagePostsQuery = _newsCollectionReference
        .where('url', isGreaterThanOrEqualTo: 'https://www.youtube.com/watch')
        .where('url', isLessThanOrEqualTo: 'https://www.z')
        .orderBy('url', descending: true)
        .orderBy('timestamp', descending: true)
        .limit(PostsLimit);

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => News.fromJson(snapshot.data))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        _newsVideoStreamController.add(posts);
      }
    });
  }

  // void referesh(String category) {
  //   print('referesh called');
  //   var pagePostsQuery = _newsCollectionReference
  //       .where('category', isEqualTo: '$category')
  //       .orderBy('date', descending: true)
  //       // #3: Limit the amount of results
  //       .limit(PostsLimit);

  //   pagePostsQuery.snapshots().listen((postsSnapshot) {
  //     var posts = postsSnapshot.documents
  //         .map((snapshot)async => News.fromJson(snapshot.data))
  //         .where((mappedItem) => mappedItem.title != null)
  //         .toList();
  //     // _lastDocument = postsSnapshot.documents.first;
  //     _allPagedNewsResults.clear();
  //     _allPagedNewsResults.add(posts);
  //     var allPosts = _allPagedNewsResults.fold<List<Future<News>>>(
  //         List<Future<News>>(),
  //         (initialValue, pageItems) => initialValue..addAll(pageItems));

  //     _newsStreamController.add(allPosts);
  //   });
  // }

  void requestMoreNews(String category) => _requestNews(category);
}
