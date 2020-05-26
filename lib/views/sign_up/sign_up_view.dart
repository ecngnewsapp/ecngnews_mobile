import 'package:ecngnews/components/app_bana.dart';
import 'package:ecngnews/components/primary_button.dart';
import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/sign_up/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                textTheme: Theme.of(context).textTheme,
                iconTheme: Theme.of(context).iconTheme,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: model.isBusy
                      ? YoutubeShimmer()
                      : Container(
                          width: SizeConfig.w,
                          height: SizeConfig.heightMultiplier * 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                  height: SizeConfig.heightMultiplier * 10,
                                  width: SizeConfig.widthMultiplier * 30,
                                  child: AppBana()),
                              VerticalSpacer(
                                space: 4,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.sizeMultiplier * 4,
                                  vertical: SizeConfig.sizeMultiplier * 4,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        onChanged: (val) {
                                          _formKey.currentState.validate();
                                          model.displayName = val;
                                        },
                                        validator: RequiredValidator(
                                            errorText: 'User Name is required'),
                                        keyboardType: TextInputType.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        cursorColor: EcngColors.primaryColor,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig
                                                          .sizeMultiplier)),
                                          hintText: 'your desired user name',
                                          labelText: 'user name',
                                          isDense: true,
                                        ),
                                      ),
                                      VerticalSpacer(
                                        space: 3,
                                      ),
                                      TextFormField(
                                        onChanged: (val) {
                                          _formKey.currentState.validate();
                                          model.email = val;
                                        },
                                        validator: EmailValidator(
                                            errorText:
                                                'Enter a valid email addresss'),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        cursorColor: EcngColors.primaryColor,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig
                                                          .sizeMultiplier)),
                                          hintText: 'yoursemail@gmail.com',
                                          labelText: 'Email',
                                          isDense: true,
                                        ),
                                      ),
                                      VerticalSpacer(
                                        space: 3,
                                      ),
                                      // passowrd
                                      TextFormField(
                                        onChanged: (val) {
                                          _formKey.currentState.validate();
                                          model.password = val;
                                        },
                                        validator: passwordValidator,
                                        obscureText: true,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        cursorColor: EcngColors.primaryColor,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig
                                                          .sizeMultiplier)),
                                          hintText: '***************',
                                          labelText: 'password',
                                          isDense: true,
                                        ),
                                      ),
                                      VerticalSpacer(),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'Forgot password?',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        ),
                                      ),
                                      PrimaryButton(
                                        text: 'Sign Up',
                                        onPressed: () {
                                          bool valid =
                                              _formKey.currentState.validate();
                                          if (valid) model.signUp();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                height: SizeConfig.heightMultiplier * 60,
                                width: SizeConfig.widthMultiplier * 90,
                                decoration: BoxDecoration(
                                  boxShadow: EcngColors.cardBoxShadow,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.sizeMultiplier),
                                ),
                              ),
                              VerticalSpacer(),
                              Text(
                                model.errorMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: EcngColors.primaryColor),
                              ),
                              Container(
                                  width: SizeConfig.widthMultiplier * 60,
                                  child: Divider(
                                    thickness: 1.1,
                                  )),
                              FlatButton(
                                onPressed: model.signIn,
                                child: Text('Sign In'),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
        viewModelBuilder: () => SignUpViewModel());
  }
}
