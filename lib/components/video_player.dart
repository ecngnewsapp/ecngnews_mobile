import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  final List<String> urls;

  const VideoList({Key key, this.urls}) : super(key: key);
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  @override
  Widget build(BuildContext context) {
    final List<YoutubePlayerController> _controllers = widget.urls
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(SizeConfig.sizeMultiplier * 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(SizeConfig.sizeMultiplier * 1.5),
              child: YoutubePlayer(
                key: ObjectKey(_controllers[index]),
                showVideoProgressIndicator: true,
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
          );
        },
        itemCount: _controllers.length,
        // separatorBuilder: (context, _) => SizedBox(height: 10.0),
      ),
    );
  }
}
