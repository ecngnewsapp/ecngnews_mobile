import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/search/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              appBar: PreferredSize(
                preferredSize:
                    Size(SizeConfig.w, SizeConfig.heightMultiplier * 10),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  height: SizeConfig.heightMultiplier * 5,
                ),
              ),
              body: SafeArea(
                child: Container(
                  child: Center(child: Text('${viewModel.title}')),
                ),
              ),
            ),
        viewModelBuilder: () => SearchViewModel());
  }
}
