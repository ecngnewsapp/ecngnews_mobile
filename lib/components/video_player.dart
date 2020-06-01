import 'package:ecngnews/models/news_model.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  final List<News> news;
  const VideoList({Key key, this.news}) : super(key: key);
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    final List<YoutubePlayerController> _controllers = widget.news
        .map((e) => e.url)
        .map<YoutubePlayerController>(
          (videoId) => YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoId),
            flags: YoutubePlayerFlags(autoPlay: false, hideControls: false),
          ),
        )
        .toList();
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            height: SizeConfig.heightMultiplier * 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(SizeConfig.sizeMultiplier * 1.5),
              boxShadow: [
                BoxShadow(
                  color: EcngColors.shadowColor,
                  offset: Offset(1, 2),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: EcngColors.shadowColor,
                  offset: Offset(-1, 2),
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
            child: Stack(
              children: [
                //player
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(SizeConfig.sizeMultiplier * 1.5),
                    ),
                    child: YoutubePlayer(
                      key: ObjectKey(_controllers[index]),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: EcngColors.primaryColor,
                      progressColors: ProgressBarColors(
                        playedColor: EcngColors.primaryColor,
                        handleColor: EcngColors.primaryColor,
                      ),
                      controller: _controllers[index],
                      actionsPadding: EdgeInsets.only(left: 16.0),
                      bottomActions: [
                        CurrentPosition(),
                        SizedBox(width: 10.0),
                        ProgressBar(isExpanded: true),
                        SizedBox(width: 10.0),
                        RemainingDuration(),
                        FullScreenButton(),
                      ],
                    ),
                  ),
                ),
                // text and duration
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(
                        SizeConfig.sizeMultiplier * 2,
                      ),
                      height: SizeConfig.heightMultiplier * 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            // alignment: Alignment.topLeft,
                            width: SizeConfig.widthMultiplier * 70,
                            child: Text(
                              '${widget.news[index].title}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                          Icon(FontAwesome.share),
                        ],
                      ),
                    )),
              ],
            ),
          );
        },
        itemCount: _controllers.length,
        // separatorBuilder: (context, _) => SizedBox(height: 10.0),
      ),
    );
  }
}
