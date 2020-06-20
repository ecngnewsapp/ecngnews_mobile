import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ShareButton extends StatefulWidget {
  const ShareButton({
    Key key,
  }) : super(key: key);

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  bool isShareClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.h,
      width: SizeConfig.w,
      child: Stack(
        children: [
          //click priventer
          Container(
            color: Colors.black.withOpacity(0.1),
            height: isShareClicked ? SizeConfig.h : 0,
            width: isShareClicked ? SizeConfig.w : 0,
          ),
          Positioned(
            left: SizeConfig.widthMultiplier,
            bottom: SizeConfig.heightMultiplier,
            child: Container(
              width: SizeConfig.w,
              height: SizeConfig.h,
              child: Stack(
                children: [
                  //whatsapp
                  AnimatedPositioned(
                    // top: 0,
                    curve: Curves.easeInOut,
                    bottom:
                        // SizeConfig.heightMultiplier * 10,
                        isShareClicked ? SizeConfig.heightMultiplier * 10 : 0,
                    duration: Duration(milliseconds: 300),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff25D366),
                      child: Icon(
                        FlutterIcons.whatsapp_faw,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    bottom:
                        isShareClicked ? SizeConfig.heightMultiplier * 8 : 0,
                    duration: Duration(milliseconds: 400),
                    left: isShareClicked ? SizeConfig.widthMultiplier * 14 : 0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff1DA1F2),
                      child: Icon(
                        FlutterIcons.twitter_ant,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 500),
                    bottom: 0,
                    left: isShareClicked ? SizeConfig.widthMultiplier * 16 : 0,
                    child: AnimatedContainer(
                        height: SizeConfig.sizeMultiplier * 5,
                        width: SizeConfig.sizeMultiplier * 5,
                        duration: Duration(milliseconds: 300),
                        child: CircleAvatar(
                          backgroundColor: Color(0xff4267B2),
                          child: Icon(
                            FlutterIcons.facebook_faw,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  //click share
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: EcngColors.primaryColor,
                      child: IconButton(
                        icon: Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            isShareClicked = !isShareClicked;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
