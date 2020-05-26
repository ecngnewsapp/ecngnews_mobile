import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  Future refresh() async {
    _navigationService.navigateTo(Routes.startUpViewRoute);
  }
}
