import 'package:ecngnews/components/news_card_item.dart';
import 'package:ecngnews/smart_components/new_categories/news_categories.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/feeds/feeds_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class FeedsView extends StatefulWidget {
  @override
  _FeedsViewState createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        onModelReady: (model) => model.listToNews(),
        builder: (context, model, child) {
          _scrollController.addListener(() {
            if (_scrollController.position.pixels ==
                _scrollController.position.maxScrollExtent) {
              model.getMoreNews();
            }
          });

          return Scaffold(
            key: _scaffoldKey,
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
                        onTap: () => _scaffoldKey.currentState.openEndDrawer(),
                        child: Icon(MaterialCommunityIcons.filter_variant)),
                  ),
                ),
              ],
            ),
            endDrawer: Drawer(
              child: SafeArea(
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'News Options',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.white),
                          ),
                          Icon(
                            Icons.clear,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      height: SizeConfig.heightMultiplier * 6.2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  model.isBusy
                      ? VideoShimmer()
                      : Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.heightMultiplier * 16),
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: model.appnews.length,
                              itemBuilder: (context, index) => Container(
                                    child: NewsItemCard(
                                      news: model.appnews[index],
                                    ),
                                  )),
                        ),
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: NewsCategoriesPan(),
                  ),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => FeedViewModel());
  }
}

class MoreNewsComponent extends StatefulWidget {
  final Function itemCreated;
  final Widget child;
  MoreNewsComponent({Key key, this.itemCreated, this.child}) : super(key: key);

  @override
  _MoreNewsComponentState createState() => _MoreNewsComponentState();
}

class _MoreNewsComponentState extends State<MoreNewsComponent> {
  @override
  void initState() {
    if (widget.itemCreated != null) {
      widget.itemCreated();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}
