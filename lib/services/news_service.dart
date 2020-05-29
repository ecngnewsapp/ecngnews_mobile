import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');
  // var _categoriesCollectionReference =
  //     Firestore.instance.collection('categories');

  static const int PostsLimit = 20;

  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  Stream listenToGeneralNews() {
    _requestNews();
    return _newsStreamController.stream;
  }

  void _requestNews() {
    var pagePostsQuery = _newsCollectionReference
        .orderBy('date', descending: true)
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

  void requestMoreNews() => _requestNews();
}
