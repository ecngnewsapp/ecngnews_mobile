import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AvatarViewModel extends FutureViewModel {
  String _avatar;
  String get avatar => _avatar;
  Future getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _avatar = await preferences.get('avatar');
  }

  @override
  Future futureToRun() => getUser();
}
