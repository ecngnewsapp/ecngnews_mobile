import 'package:ecngnews/components/app_bana.dart';
import 'package:ecngnews/components/primary_button.dart';
import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/sign_in/sign_in_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:stacked/stacked.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ]);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
        builder: (context, viewModel, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                textTheme: Theme.of(context).textTheme,
                iconTheme: Theme.of(context).iconTheme,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: viewModel.isBusy
                      ? VideoShimmer()
                      : Container(
                          width: SizeConfig.w,
                          height: SizeConfig.heightMultiplier * 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AppBana(),
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
                                      // EmailInputComponent(
                                      //   key: _formKey,
                                      // ),
                                      TextFormField(
                                        onChanged: (val) {
                                          _formKey.currentState.validate();
                                          viewModel.email = val;
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
                                          viewModel.password = val;
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
                                        text: 'Sign In',
                                        onPressed: () {
                                          bool valid =
                                              _formKey.currentState.validate();
                                          if (valid)
                                            viewModel.signInWithEmail();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                height: SizeConfig.heightMultiplier * 50,
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
                                viewModel.errorMessage,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: EcngColors.primaryColor),
                              ),
                              VerticalSpacer(
                                  // space: 8,
                                  ),
                              Container(
                                  width: SizeConfig.widthMultiplier * 60,
                                  child: Divider(
                                    thickness: 1.1,
                                  )),
                              FlatButton(
                                onPressed: viewModel.signUp,
                                child: Text('Sign Up'),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
        viewModelBuilder: () => SignInViewModel());
  }
}
