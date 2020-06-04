import 'package:ecngnews/components/vertical_spacer.dart';
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
                    VerticalSpacer(),
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
