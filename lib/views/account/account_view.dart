import 'package:ecngnews/components/icon_text_button.dart';
import 'package:ecngnews/components/vertical_spacer.dart';
import 'package:ecngnews/smart_components/signin_dialog/signin_dialog_component.dart';
import 'package:ecngnews/utils/ecng_assets.dart';
import 'package:ecngnews/utils/ecng_theme.dart';
import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/account/account_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked/stacked.dart';

class AccountView extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: model.isBusy
                  ? CircularProgressIndicator()
                  : SafeArea(
                      child: Center(
                      child: model.isAnonymous
                          ? SignInDialog()
                          : Container(
                              width: SizeConfig.widthMultiplier * 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  //card 1
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.sizeMultiplier * 2),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // AvatarComponent()
                                            Container(
                                              clipBehavior: Clip.antiAlias,
                                              width:
                                                  SizeConfig.heightMultiplier *
                                                      12,
                                              height:
                                                  SizeConfig.heightMultiplier *
                                                      12,
                                              child: FadeInImage(
                                                image: NetworkImage(
                                                    '${model.user.avatar}'),
                                                placeholder:
                                                    AssetImage(EcngAssets.logo),
                                              ),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            SizedBox(
                                              width:
                                                  SizeConfig.widthMultiplier *
                                                      4,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${model.user.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  IconTextButton(
                                                    onPressed: null,
                                                    text: 'Edit Profile',
                                                    icon: FontAwesome5.edit,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeConfig.heightMultiplier * 4,
                                        ),
                                        // edit profile
                                        IconTextButton(
                                          icon: Icons.account_circle,
                                          onPressed: null,
                                          text: 'My Profile',
                                        ),
                                      ],
                                    ),
                                    height: SizeConfig.heightMultiplier * 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: EcngColors.cardBoxShadow,
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.sizeMultiplier),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.heightMultiplier * 4,
                                  ),
                                  //card 2
                                  Container(
                                    padding: EdgeInsets.all(
                                        SizeConfig.sizeMultiplier * 2),
                                    child: Column(
                                      children: [
                                        IconTextButton(
                                          icon: Icons.notifications,
                                          onPressed: null,
                                          text: 'notification',
                                        ),
                                        //my fevorite
                                        VerticalSpacer(),
                                        IconTextButton(
                                          onPressed: null,
                                          text: 'My Favourite',
                                          icon: MaterialCommunityIcons
                                              .heart_outline,
                                        ),

                                        VerticalSpacer(),
                                        IconTextButton(
                                          icon: Icons.settings,
                                          onPressed: null,
                                          text: 'Settings',
                                        ),
                                        VerticalSpacer(),
                                        IconTextButton(
                                          icon: Icons.star_border,
                                          onPressed: null,
                                          text: 'Rate Us',
                                        ),
                                        VerticalSpacer(
                                          space: 6,
                                        ),
                                        IconTextButton(
                                          icon: Icons.exit_to_app,
                                          onPressed: model.signOut,
                                          text: 'Sign Out',
                                        ),
                                      ],
                                    ),
                                    height: SizeConfig.heightMultiplier * 40,
                                    width: SizeConfig.w,
                                    decoration: BoxDecoration(
                                        boxShadow: EcngColors.cardBoxShadow,
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.sizeMultiplier)),
                                  ),
                                ],
                              ),
                            ),
                    )),
            ),
        viewModelBuilder: () => AccountViewModel());
  }
}
