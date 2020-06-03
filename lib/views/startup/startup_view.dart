import 'package:ecngnews/utils/ecng_strings.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/startup/startup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  static final String navigation = '/landing';

  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
        builder: (context, viewModel, child) => SingleChildScrollView(
              child: Container(
                height: SizeConfig.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.heightMultiplier * 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: SizeConfig.widthMultiplier * 60,
                            child: Text(
                              EcngStrings.welcome,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Container(
                          //   width: SizeConfig.widthMultiplier * 60,
                          //   child: Text(
                          //     EcngStrings.toEcngApp,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .subtitle2
                          //         .copyWith(
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.normal),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: SizeConfig.heightMultiplier * 18,
                      width: SizeConfig.widthMultiplier * 36,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Container(
                        padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
                        width: SizeConfig.w,
                        child: Text(
                          EcngStrings.landingInfo,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.white),
                        )),
                    GestureDetector(
                      // onTap: () => Navigator.pushNamed(context, HomePage.navigation),
                      child: Container(
                        color: Color.fromRGBO(255, 255, 255, .16),
                        width: SizeConfig.w,
                        child: FlatButton(
                          onPressed: viewModel.navigateHome,
                          child: Text(
                            viewModel.signedIn
                                ? EcngStrings.getStarted
                                : 'Continue',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: EcngColors.primaryColor,
                ),
              ),
            ),
        viewModelBuilder: () => StartupViewModel());
  }
}
