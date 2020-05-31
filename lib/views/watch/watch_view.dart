import 'package:ecngnews/components/video_player.dart';
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
    return ViewModelBuilder<WatchViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: VideoList(
                urls: model.appnews.map((e) => e.url).toList(),
              ),
            ),
        viewModelBuilder: () => WatchViewModel());
  }
}
