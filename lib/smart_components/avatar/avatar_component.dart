import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecngnews/smart_components/avatar/avatar_viemodel.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

//avatar
class AvatarComponent extends StatelessWidget {
  const AvatarComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AvatarViewModel>.reactive(
        builder: (context, model, child) => Container(
              clipBehavior: Clip.antiAlias,
              width: SizeConfig.heightMultiplier * 12,
              height: SizeConfig.heightMultiplier * 12,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: "${model.avatar}",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: EcngColors.primaryColor,
              ),
            ),
        viewModelBuilder: () => AvatarViewModel());
  }
}
