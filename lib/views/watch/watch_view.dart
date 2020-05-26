import 'package:ecngnews/smart_components/new_categories/news_categories.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchView extends StatefulWidget {
  @override
  _WatchViewState createState() => _WatchViewState();
}

class _WatchViewState extends State<WatchView> {
  YoutubePlayerController _youtubePlayerController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: '1Rkn6rnsgc4',
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHideAnnotation: true,
        forceHD: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: SizeConfig.heightMultiplier * 15,
                  left: SizeConfig.sizeMultiplier * 1.5,
                  right: SizeConfig.sizeMultiplier * 1.5,
                  bottom: SizeConfig.sizeMultiplier * 1.5),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: SizeConfig.heightMultiplier * 30,
//                    padding: EdgeInsets.all(10),
                    decoration: EcngTheme.cardDecoration,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: YoutubePlayer(
                            width: SizeConfig.widthMultiplier * 90,
                            bottomActions: <Widget>[
                              Icon(Icons.play_arrow),
                              Icon(Icons.pause),
                            ],
                            controller: _youtubePlayerController,
                          ),
                          alignment: Alignment.topCenter,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: NewsCategoriesPan(
                isDecorated: false,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(),
    );
  }
}
