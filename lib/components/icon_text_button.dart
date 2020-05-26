import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final onPressed;
  final text;
  final IconData icon;
  const IconTextButton({
    Key key,
    @required this.onPressed,
    this.text = 'default',
    this.icon = Icons.offline_bolt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: SizeConfig.widthMultiplier * 2,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
