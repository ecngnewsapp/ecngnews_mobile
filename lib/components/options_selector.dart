import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class OptionSelector extends StatelessWidget {
  final String text;

  const OptionSelector({Key key, this.text = 'default'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.sizeMultiplier * 3,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(SizeConfig.sizeMultiplier * 2),
          right: Radius.circular(SizeConfig.sizeMultiplier * 2),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Colors.black45),
      ),
    );
  }
}
