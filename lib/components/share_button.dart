import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: EcngColors.primaryColor,
      child: IconButton(
        icon: Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
