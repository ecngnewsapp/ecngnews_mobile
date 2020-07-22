import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  String email;
  String displayName;
  String password;
  String confirmPassword;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DialogService _dialogService = locator<DialogService>();
  Future signUp() async {
    setBusy(true);
    try {
      var result = await _authenticationService.signUpwithEmailPassword(
        userEmail: email,
        userPassword: password,
        userName: displayName,
      );
      if (result != null && result is FirebaseUser) {
        final user = User(
          id: result.uid,
          name: displayName,
          email: email,
          avatar:
              'https://firebasestorage.googleapis.com/v0/b/ecngnewsapp-346cd.appspot.com/o/defaultavatar.png?alt=media&token=e2decb67-0874-4481-8963-c698798271f1',
        );
        print(user.name.toString());
        await _authenticationService.saveToFirebase(user);
        await _authenticationService.saveDataToSP(user);
        await _authenticationService.setSignIn();

        _navigationService.replaceWith(Routes.homeViewRoute);
      }
    } catch (e) {
      _dialogService.showDialog(
          title: 'SignUp error', description: 'SignUp error');
    }
    notifyListeners();
  }

  Future signIn() async {
    _navigationService.replaceWith(Routes.signInViewRoute);
    notifyListeners();
  }
}
