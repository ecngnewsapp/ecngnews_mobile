import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/like_model.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');

  List<List<News>> _allPagedNewsResults = List<List<News>>();

  static const int PostsLimit = 20;

  // DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  bool get hasMorsPost => _hasMorePosts;
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  final StreamController<List<News>> _newsVideoStreamController =
      StreamController<List<News>>.broadcast();
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

  Future commentOnNews() async {}

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

  void _requestNews(String category) {
    var pagePostsQuery = _newsCollectionReference
        .where('category', isEqualTo: '$category')
        .orderBy('timestamp', descending: true)
        // #3: Limit the amount of results
        .limit(PostsLimit);

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => News.fromJson(snapshot.data))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        _newsStreamController.add(posts);
      }
    });
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

  void referesh(String category) {
    print('referesh called');
    var pagePostsQuery = _newsCollectionReference
        .where('category', isEqualTo: '$category')
        .orderBy('date', descending: true)
        // #3: Limit the amount of results
        .limit(PostsLimit);

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      var posts = postsSnapshot.documents
          .map((snapshot) => News.fromJson(snapshot.data))
          .where((mappedItem) => mappedItem.title != null)
          .toList();
      // _lastDocument = postsSnapshot.documents.first;
      _allPagedNewsResults.clear();
      _allPagedNewsResults.add(posts);
      var allPosts = _allPagedNewsResults.fold<List<News>>(List<News>(),
          (initialValue, pageItems) => initialValue..addAll(pageItems));

      _newsStreamController.add(allPosts);
    });
  }

  void requestMoreNews(String category) => _requestNews(category);
}
