import 'package:ecngnews/components/app_bana.dart';
import 'package:ecngnews/components/primary_button.dart';
import 'package:ecngnews/components/social_signin.dart';
import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/utils/ecng_strings.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/welcome/welcome_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:stacked/stacked.dart';

class WelcomeView extends StatefulWidget {
  WelcomeView({Key key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomeViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: model.isBusy
                  ? VideoShimmer()
                  : Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 10,
                          ),
                          AppBana(),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 5,
                          ),
                          Container(
                            // padding:
                            //     EdgeInsets.all(SizeConfig.sizeMultiplier * 1.5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  color: EcngColors.shadowColor,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.sizeMultiplier * 2),
                            ),
                            margin:
                                EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                            padding:
                                EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                            child: model.isBusy
                                ? ProfileShimmer()
                                : Center(
                                    child: Column(
                                      children: [
                                        // welcome text
                                        Text(
                                          EcngStrings.welcome,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 30),
                                        ),
                                        //sign in options
                                        Text(
                                          'Sign in with Google',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(fontSize: 18),
                                        ),
                                        VerticalSpacer(
                                          space: 4,
                                        ),
                                        //
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: model.signInWithGoogle,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    SigninWithGoogleWidget(),
                                                  ],
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: SizeConfig.heightMultiplier,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'OR',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6
                                                    .copyWith(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        ),
                                        VerticalSpacer(
                                          space: 4,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              PrimaryButton(
                                                text: 'Sign In',
                                                onPressed: model.signIn,
                                              ),
                                              SizedBox(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        6,
                                              ),
                                              PrimaryButton(
                                                text: 'Sign Up',
                                                onPressed: model.signUp,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 8,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.sizeMultiplier * 10,
                            ),
                            child: Divider(
                              thickness: 1.2,
                            ),
                          ),
                          FlatButton(
                            onPressed: () => model.anonymousSignIn(),
                            child: Text(
                              'Skip',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
        viewModelBuilder: () => WelcomeViewModel());
  }
}
