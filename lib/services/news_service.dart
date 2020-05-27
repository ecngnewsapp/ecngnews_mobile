import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');
  List<List<News>> _allPagedNewsResults = List<List<News>>();

  static const int PostsLimit = 20;

  DocumentSnapshot _lastDocument;
  bool _hasMorePosts = true;
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  Stream listenToNews() {
    _requestPosts();
    return _newsStreamController.stream;
  }

  void referesh() {
    // _newsStreamController.done;
  }

  void _requestPosts() {
    var pagePostsQuery = _newsCollectionReference
        .orderBy('date')
        // #3: Limit the amount of results
        .limit(PostsLimit);

    if (_lastDocument != null) {
      pagePostsQuery = pagePostsQuery.startAfterDocument(_lastDocument);
    }

    if (!_hasMorePosts) return;

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
        }

        // #14: Determine if there's more posts to request
        _hasMorePosts = posts.length == PostsLimit;
      }
    });
  }

  void requestMoreNews() => _requestPosts();
}
