import 'package:ecngnews/components/news_card_item.dart';
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.red));

    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        List<Widget> _pages = [
          FeedsView(
            child: model.appnews == null
                ? VideoShimmer()
                : ListView.builder(
                    itemCount: model.appnews.length,
                    itemBuilder: (context, index) => MoreNewsComponent(
                      itemCreated: () {
                        if (index % 20 == 0) model.getMoreNews();
                      },
                      child: NewsItemCard(
                        news: model.appnews[index],
                      ),
                    ),
                  ),
          ),
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

        return Scaffold(
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
                      // onTap: () => _scaffoldKey.currentState.openEndDrawer(),
                      child: Icon(MaterialCommunityIcons.filter_variant)),
                ),
              ),
            ],
          ),
          body: PageView(
            onPageChanged: _changePage,
            controller: pageController,
            children: _pages,
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
