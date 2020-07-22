import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final onPressed;
  const PrimaryButton({
    Key key,
    this.text = 'DEFAULT',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.sizeMultiplier * 5,
          vertical: SizeConfig.sizeMultiplier * .5),
      elevation: 0,
      textTheme: Theme.of(context).buttonTheme.textTheme,
      child: Text(
        text,
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      disabledTextColor: Colors.black,
      disabledColor: Color.fromRGBO(222, 222, 222, 100),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier)),
    );
  }
}
