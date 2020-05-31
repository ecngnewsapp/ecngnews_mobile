// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ecngnews/views/startup/startup_view.dart';
import 'package:ecngnews/views/account/account_view.dart';
import 'package:ecngnews/views/feeds/feeds_view.dart';
import 'package:ecngnews/views/fevourite/favourit_view.dart';
import 'package:ecngnews/views/home/home_view.dart';
import 'package:ecngnews/views/news_detail/news_detial_view.dart';
import 'package:ecngnews/views/news_source_detial/news_source_detial_view.dart';
import 'package:ecngnews/views/profile/profile_view.dart';
import 'package:ecngnews/views/search/search_view.dart';
import 'package:ecngnews/views/sign_in/sign_in_view.dart';
import 'package:ecngnews/views/sign_up/sign_up_view.dart';
import 'package:ecngnews/views/watch/watch_view.dart';
import 'package:ecngnews/views/welcome/welcome_view.dart';
import 'package:ecngnews/views/error/error_view.dart';

abstract class Routes {
  static const startUpViewRoute = '/';
  static const accountViewRoute = '/account-view-route';
  static const feedsViewRoute = '/feeds-view-route';
  static const favouriteViewRoute = '/favourite-view-route';
  static const homeViewRoute = '/home-view-route';
  static const newsDetailViewRoute = '/news-detail-view-route';
  static const newsSourceDetialViewRoute = '/news-source-detial-view-route';
  static const profileViewRoute = '/profile-view-route';
  static const searchViewRoute = '/search-view-route';
  static const signInViewRoute = '/sign-in-view-route';
  static const signUpViewRoute = '/sign-up-view-route';
  static const watchViewRoute = '/watch-view-route';
  static const weclomeViewRoute = '/weclome-view-route';
  static const errorViewRoute = '/error-view-route';
  static const all = {
    startUpViewRoute,
    accountViewRoute,
    feedsViewRoute,
    favouriteViewRoute,
    homeViewRoute,
    newsDetailViewRoute,
    newsSourceDetialViewRoute,
    profileViewRoute,
    searchViewRoute,
    signInViewRoute,
    signUpViewRoute,
    watchViewRoute,
    weclomeViewRoute,
    errorViewRoute,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.startUpViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => StartUpView(),
          settings: settings,
        );
      case Routes.accountViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AccountView(),
          settings: settings,
        );
      case Routes.feedsViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => FeedsView(),
          settings: settings,
        );
      case Routes.favouriteViewRoute:
        if (hasInvalidArgs<FavouriteViewArguments>(args)) {
          return misTypedArgsRoute<FavouriteViewArguments>(args);
        }
        final typedArgs =
            args as FavouriteViewArguments ?? FavouriteViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => FavouriteView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.newsDetailViewRoute:
        if (hasInvalidArgs<NewsDetailViewArguments>(args)) {
          return misTypedArgsRoute<NewsDetailViewArguments>(args);
        }
        final typedArgs =
            args as NewsDetailViewArguments ?? NewsDetailViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => NewsDetailView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.newsSourceDetialViewRoute:
        if (hasInvalidArgs<NewsSourceDetialViewArguments>(args)) {
          return misTypedArgsRoute<NewsSourceDetialViewArguments>(args);
        }
        final typedArgs = args as NewsSourceDetialViewArguments ??
            NewsSourceDetialViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => NewsSourceDetialView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.profileViewRoute:
        if (hasInvalidArgs<ProfileViewArguments>(args)) {
          return misTypedArgsRoute<ProfileViewArguments>(args);
        }
        final typedArgs =
            args as ProfileViewArguments ?? ProfileViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ProfileView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.searchViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SearchView(),
          settings: settings,
        );
      case Routes.signInViewRoute:
        if (hasInvalidArgs<SignInViewArguments>(args)) {
          return misTypedArgsRoute<SignInViewArguments>(args);
        }
        final typedArgs = args as SignInViewArguments ?? SignInViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignInView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.signUpViewRoute:
        if (hasInvalidArgs<SignUpViewArguments>(args)) {
          return misTypedArgsRoute<SignUpViewArguments>(args);
        }
        final typedArgs = args as SignUpViewArguments ?? SignUpViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.watchViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => WatchView(),
          settings: settings,
        );
      case Routes.weclomeViewRoute:
        if (hasInvalidArgs<WeclomeViewArguments>(args)) {
          return misTypedArgsRoute<WeclomeViewArguments>(args);
        }
        final typedArgs =
            args as WeclomeViewArguments ?? WeclomeViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => WelcomeView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.errorViewRoute:
        if (hasInvalidArgs<ErrorViewArguments>(args)) {
          return misTypedArgsRoute<ErrorViewArguments>(args);
        }
        final typedArgs = args as ErrorViewArguments ?? ErrorViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => ErrorView(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//FavouriteView arguments holder class
class FavouriteViewArguments {
  final Key key;
  FavouriteViewArguments({this.key});
}

//NewsDetailView arguments holder class
class NewsDetailViewArguments {
  final Key key;
  NewsDetailViewArguments({this.key});
}

//NewsSourceDetialView arguments holder class
class NewsSourceDetialViewArguments {
  final Key key;
  NewsSourceDetialViewArguments({this.key});
}

//ProfileView arguments holder class
class ProfileViewArguments {
  final Key key;
  ProfileViewArguments({this.key});
}

//SignInView arguments holder class
class SignInViewArguments {
  final Key key;
  SignInViewArguments({this.key});
}

//SignUpView arguments holder class
class SignUpViewArguments {
  final Key key;
  SignUpViewArguments({this.key});
}

//WeclomeView arguments holder class
class WeclomeViewArguments {
  final Key key;
  WeclomeViewArguments({this.key});
}

//ErrorView arguments holder class
class ErrorViewArguments {
  final Key key;
  ErrorViewArguments({this.key});
}
