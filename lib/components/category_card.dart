import 'package:ecngnews/models/news_category.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
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
      margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: Container(
              height: SizeConfig.sizeMultiplier * 8,
              width: SizeConfig.sizeMultiplier * 8,
              decoration: BoxDecoration(
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: EcngColors.primaryColor.withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        )
                      ]
                    : [],
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: newsCategory.avatar != null &&
                            newsCategory.avatar.isNotEmpty
                        ? NetworkImage('${newsCategory.avatar}')
                        : AssetImage(EcngAssets.logo)),
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.sizeMultiplier * 2),
                ),
              ),
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
