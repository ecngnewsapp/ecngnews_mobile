import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AccountViewModel extends FutureViewModel {
  User _user;
  User get user => _user;
  bool _isAnonymous;
  bool get isAnonymous => _isAnonymous;
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  Future signOut() async {
    print('invoked');
    await _authenticationService.signOut();
    _navigationService.navigateTo(Routes.weclomeViewRoute);
  }

  Future getUser() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final result = await firebaseAuth.currentUser();
    _isAnonymous = result.isAnonymous;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _user = User(
      name: preferences.getString('name'),
      email: result.email,
      avatar: preferences.getString('avatar'),
    );
    print(result.displayName);
  }

  @override
  Future futureToRun() => getUser();
}
