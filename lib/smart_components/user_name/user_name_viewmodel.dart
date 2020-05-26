import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class UserNameViewModel extends FutureViewModel {
  String _userName;
  String get userName => _userName;

  Future getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _userName = preferences.getString('name');
  }

  @override
  Future futureToRun() => getUserName();
}
