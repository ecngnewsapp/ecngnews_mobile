import 'package:ecngnews/components/icon_text_button.dart';
import 'package:ecngnews/smart_components/user_name/user_name_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

class UserNameComponent extends StatelessWidget {
  const UserNameComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserNameViewModel>.reactive(
        builder: (context, model, child) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.userName}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  IconTextButton(
                    onPressed: null,
                    text: 'Edit Profile',
                    icon: FontAwesome5.edit,
                  ),
                ],
              ),
            ),
        viewModelBuilder: () => UserNameViewModel());
  }
}
