import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ecngnews/utils/router.gr.dart';

class WelcomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  //
  Future signInWithGoogle() async {
    setBusy(true);
    var result = await _authenticationService.signInWithGoogle();

    if (result is FirebaseUser) {
      final user = User(
        id: result.uid,
        name: result.displayName,
        email: result.email,
        avatar: result.photoUrl,
      );
      await _authenticationService.saveToFirebase(user);
      await _authenticationService.saveDataToSP(user);
      await _authenticationService.setSignIn();

      if (result != null) {
        await _navigationService.navigateTo(Routes.homeViewRoute);
        setBusy(false);
      }
    } else if (result is String) {
      setBusy(false);
      _dialogService.showConfirmationDialog(
        title: 'Sign In error',
        description: 'Please try again',
      );
    } else {
      await _navigationService.navigateTo(Routes.errorViewRoute);
      setBusy(false);
    }
  }

  // Future signInWithFacebook() async {
  //   setBusy(true);
  //   var result = await _authenticationService.logInwithFacebook();

  //   if (result is FirebaseUser) {
  //     final user = User(
  //       id: result.uid,
  //       name: result.displayName,
  //       email: result.email,
  //       avatar: result.photoUrl,
  //     );
  //     await _authenticationService.saveToFirebase(user);
  //     await _authenticationService.saveDataToSP(user);
  //     await _authenticationService.setSignIn();

  //     if (result != null) {
  //       _navigationService.navigateTo(Routes.homeViewRoute);
  //     }
  //   } else if (result is String) {
  //     _dialogService.showConfirmationDialog(
  //       title: 'Sign In error',
  //       description: 'Please try again',
  //     );
  //   } else {
  //     setBusy(false);
  //     _navigationService.navigateTo(Routes.errorViewRoute);
  //   }
  //   notifyListeners();
  // }

  //
  Future anonymousSignIn() async {
    setBusy(true);
    var result = await _authenticationService.signInAnonymously();
    if (result is FirebaseUser && result != null) {
      await _authenticationService.setSignIn();
      await _navigationService.navigateTo(Routes.homeViewRoute);
      setBusy(false);
    } else if (result is String) {
      setBusy(false);
      _dialogService.showConfirmationDialog(
        title: 'Anonymous Sign In error',
        description: 'Please try again',
      );
    } else {
      await _navigationService.navigateTo(Routes.errorViewRoute);
      setBusy(false);
    }
  }

  // check if user is anoymous
  Future checkAnonymous() async {
    setBusy(true);
    var result = await _authenticationService.checkUserAnonymous();
    if (result != null && result is bool) {
      setBusy(false);
      if (result) {
        _navigationService.navigateTo(Routes.weclomeViewRoute);
      }
    } else {
      setBusy(false);
      _navigationService.navigateTo(Routes.errorViewRoute);
    }
  }

  Future signIn() => _navigationService.navigateTo(Routes.signInViewRoute);
  Future signUp() => _navigationService.navigateTo(Routes.signUpViewRoute);
}
