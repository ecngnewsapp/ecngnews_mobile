import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  CollectionReference _newsCollectionReference =
      Firestore.instance.collection('contents');
//comment controller
  CollectionReference _newsCommentCollectionReference =
      Firestore.instance.collection('comments');
  //news Controller
  final StreamController<List<News>> newsController =
      StreamController<List<News>>.broadcast();
  List<List<News>> _allPagedResult = List<List<News>>();
  // page limit
  static const int pageLimit = 20;
  // last document
  DocumentSnapshot _lastDocument;
  //
  bool _hasMoreNews = true;
  //listing to post in realtime
  Stream listenToNewsInRealtime() {
    //
    _requestNews();
    return newsController.stream;
  }

  void _requestNews() {
    //query latast news
    Query newsPostQuery =
        _newsCollectionReference.orderBy('date').limit(pageLimit);
  }
}
