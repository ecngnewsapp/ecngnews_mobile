import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class CommentBobble extends StatelessWidget {
  final Comments comment;
  const CommentBobble({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        TimeOfDay.fromDateTime(DateTime.parse(comment.time)).format(context);

    return ViewModelBuilder<CommentBobbleViewmodel>.reactive(
        builder: (context, model, child) {
          return Container(
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
            width: SizeConfig.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  width: SizeConfig.heightMultiplier * 4,
                  height: SizeConfig.heightMultiplier * 4,
                  child: FutureBuilder(
                    future: model.getUserDetails(model.user.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.hasData
                          ? FadeInImage(
                              image: NetworkImage('${model.user.avatar}'),
                              placeholder: AssetImage(EcngAssets.logo),
                            )
                          : Shimmer.fromColors(
                              child: CircleAvatar(),
                              baseColor:
                                  EcngColors.primaryColor.withOpacity(.9),
                              highlightColor:
                                  EcngColors.primaryColor.withOpacity(.1));
                    },
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                ),
                Column(
                  children: [
                    FutureBuilder(
                      future: model.getUserDetails(comment.owner),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return snapshot.hasData
                            ? Text(
                                '${snapshot.data.name}',
                                style: TextStyle(fontSize: 10),
                              )
                            : Container(
                                width: SizeConfig.widthMultiplier * 20,
                                child: Shimmer.fromColors(
                                    child: Text('loading..'),
                                    baseColor: EcngColors.primaryColor,
                                    highlightColor: EcngColors.primaryColor
                                        .withOpacity(0.1)),
                              );
                      },
                    ),
                    Container(
                      width: SizeConfig.widthMultiplier * 40,
                      decoration: BoxDecoration(
                        color: EcngColors.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(SizeConfig.sizeMultiplier * 2),
                          topRight:
                              Radius.circular(SizeConfig.sizeMultiplier * 2),
                          bottomRight:
                              Radius.circular(SizeConfig.sizeMultiplier * 2),
                        ),
                      ),
                      padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                      margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                      child: Text('${comment.comment}'),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.widthMultiplier * 12,
                  child: Text(
                    '$time',
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        viewModelBuilder: () => CommentBobbleViewmodel());
  }
}

class MyChatBobble extends StatelessWidget {
  final Comments comment;

  const MyChatBobble({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        TimeOfDay.fromDateTime(DateTime.parse(comment.time)).format(context);
    return Container(
      margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: SizeConfig.widthMultiplier * 14,
            child: Text(
              '$time',
              softWrap: true,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          Container(
            width: SizeConfig.widthMultiplier * 50,
            decoration: BoxDecoration(
              color: EcngColors.grayColor2.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.sizeMultiplier * 2),
                topRight: Radius.circular(SizeConfig.sizeMultiplier * 2),
                bottomLeft: Radius.circular(SizeConfig.sizeMultiplier * 2),
              ),
            ),
            padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
            margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
            child: Text('${comment.comment}'),
          ),
        ],
      ),
    );
  }
}

class CommentBobbleViewmodel extends BaseViewModel {
  User _user = User();
  User get user => _user;
  // NewsService _newsService = locator<NewsService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Future<User> getUserDetails(String userid) async {
    _user = await _authenticationService.getUserData(userid);
    print('user id $_user');
    return _user;
  }
}
