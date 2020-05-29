import 'dart:math';

import 'package:stacked/stacked.dart';

class SearchViewModel extends StreamViewModel<int> {
  String get title => 'This is the time since epoch in seconds \n $data';
  Stream<int> numbersStream([int delay = 500]) async* {
    var random = Random();
    while (true) {
      await Future.delayed(Duration(milliseconds: delay));
      yield random.nextInt(999);
    }
  }

  @override
  Stream<int> get stream => numbersStream();
}
