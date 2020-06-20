import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

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
          Positioned(
            left: SizeConfig.widthMultiplier,
            bottom: SizeConfig.heightMultiplier,
            child: Container(
              color: Colors.black.withOpacity(0.1),
              height: isShareClicked ? SizeConfig.h : 0,
              width: isShareClicked ? SizeConfig.w : 0,
            ),
          ),
          Positioned(
            left: SizeConfig.widthMultiplier,
            bottom: SizeConfig.heightMultiplier,
            child: Container(
              width: SizeConfig.heightMultiplier * 15,
              height: SizeConfig.heightMultiplier * 15,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    top: 0,
                    duration: Duration(milliseconds: 200),
                    child: CircleAvatar(),
                  ),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(),
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
