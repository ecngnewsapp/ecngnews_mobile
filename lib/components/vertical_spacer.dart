import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class VerticalSpacer extends StatelessWidget {
  final double space;
  const VerticalSpacer({
    Key key,
    this.space = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * space,
    );
  }
}
