import 'package:stacked/stacked.dart';

class CommentsViewModel extends StreamViewModel {
  Stream listentToComments() async* {}
  @override
  Stream get stream => listentToComments();
}
