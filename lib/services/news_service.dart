import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');
  var _categoriesCollectionReference =
      Firestore.instance.collection('categories');
  List<List<News>> _allPagedNewsResults = List<List<News>>();

  static const int PostsLimit = 20;

  DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  Stream<dynamic> listenToGeneralNews() async* {
    _requestNews('general');
    yield* _newsStreamController.stream;
  }

  Future<List<NewsCategory>> getCategory() async {
    List<NewsCategory> categories = List<NewsCategory>();
    _categoriesCollectionReference
        .snapshots()
        .listen((data) => data.documents.forEach((doc) => {
              // print(doc['avatar']),
              // print(doc.documentID),
              categories.add(
                NewsCategory(avatar: doc['avatar'], categories: doc.documentID),
              )
            }));
    // print('gotten cat ${_categories[0].categories}');
    // print('failded to get gotten cat ');
    return categories;
  }

  void _requestNews(String category) {
    var pagePostsQuery = _newsCollectionReference
        .where('category', isEqualTo: '$category')
        .orderBy('date', descending: true)
        // #3: Limit the amount of results
        .limit(PostsLimit);

    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMorePosts) {
      print('out of document snapshots need to referesh');
      return;
    }

    var currentRequestIndex = _allPagedNewsResults.length;

    pagePostsQuery.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => News.fromJson(snapshot.data))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        var pageExists = currentRequestIndex < _allPagedNewsResults.length;

        if (pageExists) {
          _allPagedNewsResults[currentRequestIndex] = posts;
        } else {
          _allPagedNewsResults.add(posts);
        }

        var allPosts = _allPagedNewsResults.fold<List<News>>(List<News>(),
            (initialValue, pageItems) => initialValue..addAll(pageItems));

        _newsStreamController.add(allPosts);

        if (currentRequestIndex == _allPagedNewsResults.length - 1) {
          _lastDocument = postsSnapshot.documents.last;
          print('last doc is ${_lastDocument.documentID}');
        }

        // #14: Determine if there's more posts to request
        _hasMorePosts = posts.length == PostsLimit;
      }
    });
  }

  void referesh() async {
    print('called referesh');
    var resetPostQuery = _newsCollectionReference
        .orderBy('date', descending: true)
        // #3: Limit the amount of results
        .limit(PostsLimit);
    resetPostQuery.snapshots().listen((event) {
      _lastDocument = event.documents.first;
      print('first doc is ${_lastDocument.documentID}');
    });
    // _allPagedNewsResults.clear();
    _requestNews('general');

    var allPosts = _allPagedNewsResults.fold<List<News>>(List<News>(),
        (initialValue, pageItems) => initialValue..addAll(pageItems));
    _newsStreamController.add(allPosts);
  }

  void requestMoreNews(String category) => _requestNews(category);
}
