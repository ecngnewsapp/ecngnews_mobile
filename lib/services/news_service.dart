import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');
  // var _newsVideoCollectionReference = Firestore.instance.collection('contents');
  var _categoriesCollectionReference =
      Firestore.instance.collection('categories');
  List<List<News>> _allPagedNewsResults = List<List<News>>();

  static const int PostsLimit = 200;

  // DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  bool get hasMorsPost => _hasMorePosts;
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  final StreamController<List<News>> _newsVideoStreamController =
      StreamController<List<News>>.broadcast();

  Stream<dynamic> listenToNews(String category) async* {
    _requestNews(category);
    yield* _newsStreamController.stream;
  }

  Stream<dynamic> listenToNewsVideos(String category) async* {
    _requestVideoNews(category);
    yield* _newsVideoStreamController.stream;
  }

  Future<List<NewsCategory>> getCategory() async {
    List<NewsCategory> categories = List<NewsCategory>();
    _categoriesCollectionReference
        .orderBy('order')
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => {
              categories.add(
                NewsCategory(avatar: doc['avatar'], categories: doc.documentID),
              )
            }));

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

  void _requestVideoNews(String category) {
    var pagePostsQuery = _newsCollectionReference
        .where('category', isEqualTo: '$category')
        .where('url', isGreaterThanOrEqualTo: 'https://www.youtube')
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
