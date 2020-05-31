import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignOutViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  Future signOut() async {
    print('invoked');
    await _authenticationService.signOut();
    _navigationService.replaceWithTransition(WelcomeView());
  }
}
