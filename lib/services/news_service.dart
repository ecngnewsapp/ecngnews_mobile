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
    // checking its not the last document
    if (_lastDocument != null) {
      newsPostQuery.startAfterDocument(_lastDocument);
    }
    // checking if we have no more news items

    if (!_hasMoreNews) return;

    //setting current request index
    int currentRequestIndex = _allPagedResult.length;

    newsPostQuery.snapshots().listen((newsSnapShots) {
      if (newsSnapShots.documents.isNotEmpty) {
        List<News> news = newsSnapShots.documents
            .map((snapShots) => News.fromJson(snapShots.data))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        //check it page exist
        bool pageExist = currentRequestIndex < _allPagedResult.length;

        if (pageExist) {
          _allPagedResult[currentRequestIndex] = news;
        }
        // if it doesn't exist add
        else {
          _allPagedResult.add(news);
        }

        // concatinate news to be shown
        List<News> allNews = _allPagedResult.fold<List<News>>(
          List<News>(),
          (initialValue, pageItems) => initialValue..addAll(pageItems),
        );

        // brotcast all news
        newsController.add(allNews);

        //saving last document only if user at current page
        if (currentRequestIndex == _allPagedResult.length - 1) {
          _lastDocument = newsSnapShots.documents.last;
        }
        _hasMoreNews = news.length == pageLimit;
      }
    });
  }
}
