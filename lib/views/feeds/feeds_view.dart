import 'package:ecngnews/components/category_card.dart';
import 'package:ecngnews/components/news_card_item.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/feeds/feeds_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class FeedsView extends StatefulWidget {
  const FeedsView({
    Key key,
  }) : super(key: key);

  @override
  _FeedsViewState createState() => _FeedsViewState();
}

class _FeedsViewState extends State<FeedsView> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return ViewModelBuilder<FeedViewModel>.reactive(
        // disposeViewModel: false,
        onModelReady: (m) => m.setNewCategoryPan(),
        builder: (context, model, child) => Column(
              children: [
                //filters
                model.isBusy
                    ? ListTileShimmer()
                    : GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.sizeMultiplier),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: model.newsCategory.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  model.setSource(
                                      '${model.newsCategory[index].categories}');
                                  currentIndex = index;
                                },
                                child: CategoryCard(
                                  isActive:
                                      index == currentIndex ? true : false,
                                  newsCategory: model.newsCategory[index],
                                ),
                              );
                            },
                          ),
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.sizeMultiplier),
                          height: SizeConfig.heightMultiplier * 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(
                                      SizeConfig.sizeMultiplier * 2)),
                              boxShadow: EcngColors.cardBoxShadow,
                              color: Colors.white),
                        ),
                      ),
                Expanded(
                    child: Container(
                  child: ListView.builder(
                    itemCount: model.appnews.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => model
                          .viewDetails('${model.appnews[index].timestamp}'),
                      child: model.isBusy
                          ? ListTileShimmer()
                          : NewsItemCard(
                              news: model.appnews[index],
                            ),
                    ),
                  ),
                )),
              ],
            ),
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
