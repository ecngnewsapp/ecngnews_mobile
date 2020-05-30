import 'package:ecngnews/components/news_card_item.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/feeds/feeds_viewmodel.dart';
import 'package:ecngnews/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        onModelReady: (m) {
          m.setNewCategoryPan();
          // m.listenToGeneralNews();
        },
        builder: (context, model, child) => Column(
              children: [
                //filters
                model.newsCategory == null
                    ? ListTileShimmer()
                    : Container(
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.sizeMultiplier),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: model.newsCategory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CategoryCard(
                              newsCategory: model.newsCategory[index],
                            );
                          },
                        ),
                        margin:
                            EdgeInsets.only(bottom: SizeConfig.sizeMultiplier),
                        height: SizeConfig.heightMultiplier * 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(
                                    SizeConfig.sizeMultiplier * 2)),
                            boxShadow: EcngColors.cardBoxShadow,
                            color: Colors.white),
                      ),
                Expanded(
                    child: Container(
                  child: model.appnews.length <= 0
                      ? Container(
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: model.referesh,
                            ),
                          ),
                        )
                      : model.isBusy
                          ? VideoShimmer()
                          : ListView.builder(
                              itemCount: model.appnews.length,
                              itemBuilder: (context, index) => NewsItemCard(
                                news: model.appnews[index],
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
