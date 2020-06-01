import 'package:ecngnews/components/category_card.dart';
import 'package:ecngnews/components/video_player.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/watch/watch_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class WatchView extends StatefulWidget {
  @override
  _WatchViewState createState() => _WatchViewState();
}

class _WatchViewState extends State<WatchView> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return ViewModelBuilder<WatchViewModel>.reactive(
        disposeViewModel: false,
        onModelReady: (m) => m.setNewCategoryPan(),
        builder: (context, model, child) => Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: SizeConfig.sizeMultiplier),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.newsCategory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          model.setSource(index);
                          currentIndex = index;
                        },
                        child: CategoryCard(
                          isActive: index == currentIndex ? true : false,
                          newsCategory: model.newsCategory[index],
                        ),
                      );
                    },
                  ),
                  margin: EdgeInsets.only(bottom: SizeConfig.sizeMultiplier),
                  height: SizeConfig.heightMultiplier * 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: model.appnews.length <= 0
                        ? Container()
                        : VideoList(
                            news: model.appnews,
                          ),
                  ),
                ),
              ],
            ),
        viewModelBuilder: () => WatchViewModel());
  }
}
