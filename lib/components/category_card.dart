import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final bool isActive;
  final Color selectecdColor;
  final NewsCategory newsCategory;
  const CategoryCard({
    Key key,
    this.newsCategory,
    this.isActive = false,
    this.selectecdColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.sizeMultiplier),
      child: Column(
        children: [
          CircleAvatar(
            radius: SizeConfig.heightMultiplier * 4.7,
            backgroundColor: isActive
                ? EcngColors.primaryColor
                : EcngColors.defaultIconColor,
            child: CachedNetworkImage(
              imageUrl: '${newsCategory.avatar}',
              imageBuilder: (context, imageProvider) => Container(
                width: SizeConfig.sizeMultiplier * 8,
                height: SizeConfig.sizeMultiplier * 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            width: SizeConfig.widthMultiplier * 14,
            child: Text(
              '${newsCategory.categories}',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: isActive
                      ? EcngColors.primaryColor
                      : EcngColors.defaultIconColor,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
