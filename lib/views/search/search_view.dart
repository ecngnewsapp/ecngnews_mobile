import 'package:ecngnews/components/news_card_item.dart';
import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        disposeViewModel: false,
        // onModelReady: (m) => m.listenToNewsSearch(''),
        builder: (context, model, child) => Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                    child: Column(
                      children: [
                        Form(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: EcngColors.defaultIconColor,
                                child: Icon(
                                  MaterialCommunityIcons.close,
                                  color: Colors.white,
                                ),
                              ),
                              //search
                              Container(
                                  width: SizeConfig.widthMultiplier * 80,
                                  child: TextFormField(
                                    cursorColor: EcngColors.primaryColor,
                                    onChanged: (search) => model.search(search),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Feather.search,
                                        size: SizeConfig.sizeMultiplier * 3,
                                      ),
                                      isDense: true,
                                      hintText: 'Search news ',
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              SizeConfig.heightMultiplier * 1.5,
                                          horizontal:
                                              SizeConfig.widthMultiplier * 5),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: .5),
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.sizeMultiplier * 10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: .6,
                                              color: EcngColors.primaryColor),
                                          borderRadius: BorderRadius.circular(
                                              SizeConfig.sizeMultiplier * 10)),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        VerticalSpacer(),
                        Container(
                          height: SizeConfig.heightMultiplier * 10,
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.heightMultiplier,
                          ),
                          // child: ListView.builder(
                          //   scrollDirection: Axis.horizontal,
                          //   itemCount: model.newsCategory.length,
                          //   itemBuilder: (BuildContext context, int index) {
                          //     return GestureDetector(
                          //       onTap: () {
                          //         model.setSource(index);
                          //         currentIndex = index;
                          //         category =
                          //             model.newsCategory[index].categories;
                          //       },
                          //       child: Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(
                          //                 SizeConfig.sizeMultiplier * 10),
                          //             border: Border.all(
                          //               color: index == currentIndex
                          //                   ? EcngColors.primaryColor
                          //                   : EcngColors.grayColor2,
                          //             )),
                          //         margin:
                          //             EdgeInsets.all(SizeConfig.sizeMultiplier),
                          //         padding: EdgeInsets.symmetric(
                          //             vertical: SizeConfig.heightMultiplier,
                          //             horizontal:
                          //                 SizeConfig.widthMultiplier * 4),
                          //         child: Text(
                          //           '${model.newsCategory[index].categories}',
                          //           textAlign: TextAlign.center,
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText1
                          //               .copyWith(
                          //                 color: index == currentIndex
                          //                     ? EcngColors.primaryColor
                          //                     : EcngColors.grayColor2,
                          //               ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: model.appnews.length,
                        itemBuilder: (context, index) => NewsItemCard(
                              news: model.appnews[index],
                            )),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => SearchViewModel());
  }
}
