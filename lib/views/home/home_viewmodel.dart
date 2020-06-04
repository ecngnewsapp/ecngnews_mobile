import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  NavigationService _navigationService = locator<NavigationService>();
  User user = User();
  Future getUser() async {
    setBusy(true);
    user = await _authenticationService.getUserDataFromSP();
    notifyListeners();

    setBusy(false);
  }

  Future signOut() async {
    await _authenticationService.signOut();
    _navigationService.navigateTo(Routes.startUpViewRoute);
  }
}
