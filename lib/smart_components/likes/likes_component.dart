import 'package:ecngnews/smart_components/likes/likes_component_viewmodel.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

class LikeComponent extends StatelessWidget {
  final String newsId;
  const LikeComponent({Key key, this.newsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LikesComponentViewModel>.reactive(
        // createNewModelOnInsert: true,
        builder: (context, model, chile) => Container(
              child: Row(
                children: [
                  Icon(MaterialCommunityIcons.heart),
                  Container(
                    width: SizeConfig.widthMultiplier * 28,
                    child: Text(
                      '${model.likes.length}',
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => LikesComponentViewModel(newsId));
  }
}
