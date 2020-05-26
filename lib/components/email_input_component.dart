import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailInputComponent extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const EmailInputComponent({Key key, this.formKey}) : super(key: key);

  @override
  _EmailInputComponentState createState() => _EmailInputComponentState();
}

class _EmailInputComponentState extends State<EmailInputComponent> {
  @override
  Widget build(BuildContext context) {
    final emailValidator = MultiValidator([
      EmailValidator(errorText: 'please enter a valid email'),
    ]);
    return Form(
      child: TextFormField(
        onChanged: (val) => widget.formKey.currentState.validate(),
        validator: emailValidator,
        keyboardType: TextInputType.emailAddress,
        style: Theme.of(context).textTheme.bodyText1,
        cursorColor: EcngColors.primaryColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(SizeConfig.sizeMultiplier)),
          hintText: 'yoursemail@gmail.com',
          labelText: 'Email',
          isDense: true,
        ),
      ),
    );
  }
}
