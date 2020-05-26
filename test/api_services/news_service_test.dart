import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecngnews/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test Service', () async {
    Firestore _fireStore = Firestore.instance;
    Stream<List<News>> getSportNews(String category) async* {
      yield* _fireStore
          .collection("contents")
          .where("category", isEqualTo: category)
          .snapshots()
          .map((event) => event.documents
              .map((document) => News.fromJson(document.data))
              .toList());
    }

    getSportNews('sports');
    expect(List<News>(), []);
  });
}
