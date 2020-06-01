import 'package:ecngnews/components/news_card_item.dart';
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
        onModelReady: (m) => m.setNewCategoryPan(),
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
                              Container(
                                  width: SizeConfig.widthMultiplier * 80,
                                  child: TextFormField(
                                    cursorColor: EcngColors.primaryColor,
                                    onChanged: (search) {
                                      setState(() {
                                        // List str = search.split('');
                                        // print(str);
                                        model.search('general', '$search');
                                      });
                                    },
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    decoration: InputDecoration(
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
                        Container(
                          height: SizeConfig.heightMultiplier * 20,
                          child: GridView.extent(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.all(20.0),
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 2,
                            // crossAxisCount: 2,
                            children: <Widget>[
                              const Text('He\'d have you all unravel at the'),
                              const Text('Heed not the rabble'),
                              const Text('Sound of screams but the'),
                              const Text('Who scream'),
                              const Text('Revolution is coming...'),
                              const Text('Revolution, they...'),
                            ],
                          ),
                        )
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
