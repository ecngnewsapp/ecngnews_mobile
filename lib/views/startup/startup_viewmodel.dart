import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  bool signedIn = false;
  Future navigateHome() async {
    bool isSignedIn = await _authenticationService.checkSignIn();
    if (isSignedIn) {
      signedIn = isSignedIn;
      await _navigationService.navigateTo(Routes.homeViewRoute);
    } else {
      signedIn = isSignedIn;

      await _navigationService.navigateTo(Routes.weclomeViewRoute);
    }
  }
}
