import 'package:ecngnews/views/fevourite/favourite_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavouritViewModel>.reactive(
        builder: (context, viewModel, child) {
          return Scaffold();
        },
        viewModelBuilder: () => FavouritViewModel());
  }
}
