import 'package:flutter/material.dart';

class FeedsView extends StatelessWidget {
  final Widget child;
  const FeedsView({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        // disposeViewModel: false,
        onModelReady: (m) {
          m.setNewCategoryPan();

          // m.refesh();
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
                            child: Container(
                                child: Column(
                              children: [
                                Text('${model.appnews.length}'),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: model.refesh,
                                ),
                              ],
                            )),
                          ),
                        )
                      : ListView.builder(
                          itemCount: model.appnews.length,
                          itemBuilder: (context, index) => MoreNewsComponent(
                            itemCreated: () {
                              if (model.morePost) {
                                model.getMoreNews();
                              }
                            },
                            child: NewsItemCard(
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
    return child;
  }
}
