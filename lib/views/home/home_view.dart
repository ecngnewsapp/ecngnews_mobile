import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/ecng_strings.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/account/account_view.dart';
import 'package:ecngnews/views/feeds/feeds_view.dart';
import 'package:ecngnews/views/home/home_viewmodel.dart';
import 'package:ecngnews/views/search/search_view.dart';
import 'package:ecngnews/views/watch/watch_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  static final String navigation = '/home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PageController pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));
    List<Widget> _pages = [
      FeedsView(),
      WatchView(),
      SearchView(),
      AccountView(),
    ];

    void _changePage(int index) async {
      _currentPage = index;

      pageController.jumpToPage(
        _currentPage,
      );
      setState(() {});
    }

    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
          endDrawer: Drawer(
            child: Container(
              padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(SizeConfig.sizeMultiplier * 10),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: SizeConfig.sizeMultiplier * 14,
                      height: SizeConfig.sizeMultiplier * 14,
                      child: FadeInImage(
                        image: NetworkImage('${model.user.avatar}'),
                        placeholder: AssetImage(EcngAssets.logo),
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.all(SizeConfig.sizeMultiplier),
                                  child: Text('* bookmarks'),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.all(SizeConfig.sizeMultiplier),
                                  child: Text(' More features commmint soon'),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Divider(),
                              Container(
                                  margin:
                                      EdgeInsets.all(SizeConfig.sizeMultiplier),
                                  child: GestureDetector(
                                    onTap: model.signOut,
                                    child: Text('Sign Out'),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              width: SizeConfig.widthMultiplier * 45,
              child: Image.asset(EcngAssets.logoAppbar),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                child: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: GestureDetector(
                      child: IconButton(
                    icon: Icon(MaterialCommunityIcons.filter_variant),
                    onPressed: _openEndDrawer,
                  )),
                ),
              ),
            ],
          ),
          body: PageView(
            onPageChanged: _changePage,
            controller: pageController,
            children: model.isBusy ? ListTileShimmer() : _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: EcngColors.defaultIconColor,
            selectedItemColor: EcngColors.primaryColor,
            showUnselectedLabels: true,
            currentIndex: _currentPage,
            onTap: _changePage,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Ionicons.md_home,
                    size: SizeConfig.sizeMultiplier * 3.5,
                  ),
                  title: Text(EcngStrings.home)),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ondemand_video,
                    size: SizeConfig.sizeMultiplier * 3.5,
                  ),
                  title: Text(EcngStrings.watch)),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome5Solid.search,
                    size: SizeConfig.sizeMultiplier * 3.5,
                  ),
                  title: Text(EcngStrings.search)),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesome5Solid.user_circle,
                  size: SizeConfig.sizeMultiplier * 3.5,
                ),
                title: Text(
                  EcngStrings.account,
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
