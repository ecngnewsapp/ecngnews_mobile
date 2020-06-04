import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignInViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  String email;

  String password;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  NavigationService _navigationService = locator<NavigationService>();
  Future signInWithEmail() async {
    setBusy(true);
    print('invoked');
    var result =
        await _authenticationService.signInwithEmailPassword(email, password);
    if (result is FirebaseUser && result != null) {
      User userData = await _authenticationService.getUserData(result.uid);
      final user = User(
          id: userData.id,
          name: userData.name,
          email: userData.email,
          avatar: userData.avatar);
      print(user.name);
      await _authenticationService.saveDataToSP(user);

      _navigationService.navigateTo(Routes.homeViewRoute);
    } else if (result is String) {
      _errorMessage = result.toString();
    } else {
      _errorMessage = 'Wrong Email or Passowrd';
    }
    print(result.toString());
    notifyListeners();
    setBusy(false);
  }

  Future signUp() async {
    await _navigationService.replaceWith(Routes.signUpViewRoute);
  }
}
