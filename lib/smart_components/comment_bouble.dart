import 'package:ecngnews/models/comment_model.dart';
import 'package:ecngnews/models/user_model.dart';
import 'package:ecngnews/services/authentication_service.dart';
import 'package:ecngnews/services/news_service.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CommentBobble extends StatelessWidget {
  final Comments comment;
  const CommentBobble({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var time =
        TimeOfDay.fromDateTime(DateTime.parse(comment.time)).format(context);

    return ViewModelBuilder<CommentBobbleViewmodel>.reactive(
        onModelReady: (model) => model.getUserDetails(comment.owner),
        builder: (context, model, child) {
          return model.currentUser
              ? Container(
                  margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FutureBuilder(
                        future: model.getUserDetails(comment.owner),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          return snapshot.hasData
                              ? CircleAvatar(
                                  backgroundColor: EcngColors.primaryColor,
                                  backgroundImage:
                                      NetworkImage('${snapshot.data.avatar}'),
                                )
                              : CircularProgressIndicator();
                        },
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
                                  : CircularProgressIndicator();
                            },
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier * 50,
                            decoration: BoxDecoration(
                              color: EcngColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    SizeConfig.sizeMultiplier * 2),
                                topRight: Radius.circular(
                                    SizeConfig.sizeMultiplier * 2),
                                bottomRight: Radius.circular(
                                    SizeConfig.sizeMultiplier * 2),
                              ),
                            ),
                            padding:
                                EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                            margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                            child: Text('${comment.comment}'),
                          ),
                        ],
                      ),
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
                    ],
                  ),
                )
              : Container(
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
                            topLeft:
                                Radius.circular(SizeConfig.sizeMultiplier * 2),
                            topRight:
                                Radius.circular(SizeConfig.sizeMultiplier * 2),
                            bottomLeft:
                                Radius.circular(SizeConfig.sizeMultiplier * 2),
                          ),
                        ),
                        padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                        margin: EdgeInsets.all(SizeConfig.sizeMultiplier),
                        child: Text('${comment.comment}'),
                      ),
                    ],
                  ),
                );
        },
        viewModelBuilder: () => CommentBobbleViewmodel());
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
    return _user;
  }

  bool _currentUser = false;
  bool get currentUser => _currentUser;

  Future<bool> isCurrentUser(String owernerId) async {
    print('called');
    String correntUserId = await _authenticationService
        .getCurrentUser()
        .then((value) => value.uid);
    if (correntUserId == owernerId) {
      _currentUser = true;
      notifyListeners();
      return _currentUser;
    } else {
      _currentUser = false;
      notifyListeners();
      return _currentUser;
    }
  }
}
