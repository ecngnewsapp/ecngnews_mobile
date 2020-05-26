import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SigninWithGoogleWidget extends StatelessWidget {
  const SigninWithGoogleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.sizeMultiplier * 7,
      height: SizeConfig.sizeMultiplier * 6,
      decoration: BoxDecoration(
        color: EcngColors.googleColor,
        borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier * .6),
      ),
      child: Icon(
        MaterialCommunityIcons.google_plus,
        color: Colors.white,
        size: SizeConfig.sizeMultiplier * 4,
      ),
    );
  }
}

class SigninWitheFacebookWidget extends StatelessWidget {
  const SigninWitheFacebookWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.sizeMultiplier * 7,
      height: SizeConfig.sizeMultiplier * 6,
      decoration: BoxDecoration(
        color: EcngColors.facebookColor,
        borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier * .6),
      ),
      child: Icon(
        MaterialCommunityIcons.facebook,
        color: Colors.white,
        size: SizeConfig.sizeMultiplier * 4,
      ),
    );
  }
}
