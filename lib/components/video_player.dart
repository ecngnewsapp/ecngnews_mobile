import 'package:ecngnews/smart_components/new_categories/news_categories.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  VideoPlayer({Key key}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  YoutubePlayerController _youtubePlayerController;
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
    return Stack(
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
    );
  }
}
