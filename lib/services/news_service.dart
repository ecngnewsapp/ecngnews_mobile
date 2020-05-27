import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  var _newsCollectionReference = Firestore.instance.collection('contents');
  // var _videoNewsReference =
  //     Firestore.instance.collection('path').orderBy('').startAt('values');
  final StreamController<List<News>> _newsStreamController =
      StreamController<List<News>>.broadcast();
  Stream listenToNews() {
    _newsCollectionReference.snapshots().listen((event) {
      if (event.documents.isNotEmpty) {
        var news = event.documents
            .map((e) => News.fromJson(e.data))
            .where(
              (element) => element.url != null,
            )
            .toList();
        _newsStreamController.add(news);
      }
    });
    return _newsStreamController.stream;
  }

  Stream getVideoNews() {
    _newsCollectionReference.snapshots().listen((event) {
      if (event.documents.isNotEmpty) {
        var news = event.documents
            .map((e) => News.fromJson(e.data))
            .where((element) => element.url.isNotEmpty)
            .toList();
        _newsStreamController.add(news);
      }
    });
    return _newsStreamController.stream;
  }

  ///to be edited
  Future requestNews() async {
    var querySnap = await _newsCollectionReference.limit(20).getDocuments();
    if (querySnap.documents.isNotEmpty) {
      return querySnap.documents
          .map((e) => News.fromJson(e.data))
          .where((element) => element.title != null)
          .toList();
    }
  }
}
