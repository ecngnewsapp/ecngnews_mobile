import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SigninDialogViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  Future signOut() async {
    print('invoked');
    await _authenticationService.signOut();
    _navigationService.navigateTo(Routes.weclomeViewRoute);
    notifyListeners();
  }
}
