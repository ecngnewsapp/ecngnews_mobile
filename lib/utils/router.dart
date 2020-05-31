import 'package:auto_route/auto_route_annotations.dart';
import 'package:ecngnews/views/account/account_view.dart';
import 'package:ecngnews/views/error/error_view.dart';
import 'package:ecngnews/views/feeds/feeds_view.dart';
import 'package:ecngnews/views/fevourite/favourit_view.dart';
import 'package:ecngnews/views/home/home_view.dart';
import 'package:ecngnews/views/news_detail/news_detial_view.dart';
import 'package:ecngnews/views/news_source_detial/news_source_detial_view.dart';
import 'package:ecngnews/views/profile/profile_view.dart';
import 'package:ecngnews/views/search/search_view.dart';
import 'package:ecngnews/views/sign_in/sign_in_view.dart';
import 'package:ecngnews/views/sign_up/sign_up_view.dart';
import 'package:ecngnews/views/startup/startup_view.dart';
import 'package:ecngnews/views/watch/watch_view.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  StartUpView startUpViewRoute;
  AccountView accountViewRoute;
  FeedsView feedsViewRoute;
  FavouriteView favouriteViewRoute;
  HomeView homeViewRoute;
  NewsDetailView newsDetailViewRoute;
  NewsSourceDetialView newsSourceDetialViewRoute;
  ProfileView profileViewRoute;
  SearchView searchViewRoute;
  SignInView signInViewRoute;
  SignUpView signUpViewRoute;
  WatchView watchViewRoute;
  WelcomeView weclomeViewRoute;
  ErrorView errorViewRoute;
}
