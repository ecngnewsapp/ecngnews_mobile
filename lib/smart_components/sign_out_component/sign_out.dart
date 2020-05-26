import 'package:ecngnews/components/icon_text_button.dart';
import 'package:ecngnews/smart_components/sign_out_component/sign_out_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignOutComponent extends StatelessWidget {
  const SignOutComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignOutViewModel>.reactive(
        builder: (context, model, child) => IconTextButton(
              icon: Icons.exit_to_app,
              onPressed: model.signOut(),
              text: 'Sign Out',
            ),
        viewModelBuilder: () => SignOutViewModel());
  }
}
