import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppBana extends StatelessWidget {
  const AppBana({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.sizeMultiplier * 4,
      ),
      height: SizeConfig.heightMultiplier * 16,
      width: SizeConfig.widthMultiplier * 36,
      child: Image.asset('${EcngAssets.logo}'),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier * 2)),
    );
  }
}
