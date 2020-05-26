import 'package:ecngnews/components/app_bana.dart';
import 'package:ecngnews/components/primary_button.dart';
import 'package:ecngnews/smart_components/signin_dialog/signin_dialog_viewmodel.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SigninDialogViewModel>.reactive(
        builder: (context, model, child) => Container(
              padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
              child: Container(
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    Align(
                        child: Text(
                      'Hello Please SIGN IN',
                      style: Theme.of(context).textTheme.headline6,
                    )),
                    Positioned(
                      top: -SizeConfig.heightMultiplier * 10,
                      child: AppBana(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PrimaryButton(
                        text: 'Sign In',
                        onPressed: model.signOut,
                      ),
                    )
                  ],
                ),
                padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 2),
                height: SizeConfig.heightMultiplier * 40,
                width: SizeConfig.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: EcngColors.cardBoxShadow,
                  borderRadius:
                      BorderRadius.circular(SizeConfig.sizeMultiplier),
                ),
              ),
            ),
        viewModelBuilder: () => SigninDialogViewModel());
  }
}
