import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';

class NewsCategoriesPan extends StatelessWidget {
  final bool isDecorated;

  const NewsCategoriesPan({Key key, this.isDecorated = true}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 14,
      decoration: BoxDecoration(
        borderRadius: isDecorated
            ? BorderRadius.vertical(
                bottom: Radius.circular(SizeConfig.sizeMultiplier * 2))
            : null,
        color: Colors.white,
        boxShadow: isDecorated
            ? [
                BoxShadow(
                    color: EcngColors.shadowColor,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 2))
              ]
            : null,
      ),
      // child: Consumer<NewsCategoriesProvider>(
      //   builder: (context, categories, child) {
      //     List<NewsCategory> data = categories.newsCategories;
      //     return ListView.builder(
      //       scrollDirection: Axis.horizontal,
      //       itemBuilder: (context, index) {
      //         return Container(
      //           padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
      //           child: Column(
      //             mainAxisSize: MainAxisSize.max,
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: <Widget>[
      //               CircleAvatar(
      //                 radius: SizeConfig.sizeMultiplier * 4,
      //                 backgroundColor: Theme.of(context).primaryColor,
      //                 child: CircleAvatar(
      //                   backgroundColor: Theme.of(context).primaryColor,
      //                   radius: SizeConfig.sizeMultiplier * 3.9,
      //                   backgroundImage: data[index].avatar != null &&
      //                           data[index].avatar.isEmpty
      //                       ? AssetImage(EcngAssets.logo)
      //                       : NetworkImage(data[index].avatar),
      //                 ),
      //               ),
      //               Text(
      //                 data[index].categories.toString(),
      //                 style: Theme.of(context)
      //                     .textTheme
      //                     .body2
      //                     .copyWith(color: EcngColors.defaultIconColor),
      //               ),
      //             ],
      //           ),
      //         );
      //       },
      //       itemCount: data.length,
      //     );
      //   },
      // ),
    );
  }
}
