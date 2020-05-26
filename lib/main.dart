import 'package:ecngnews/utils/locator.dart';
import 'package:ecngnews/utils/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stacked_services/stacked_services.dart';

import 'components/options_selector.dart';
import 'utils/ecng_theme.dart';
import 'utils/size_config.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: EcngColors.primaryColor));
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: 'Ecngnews',
              theme: EcngTheme.lightTheme,
//              initialRoute: '/',
              initialRoute: Routes.startUpViewRoute,
              onGenerateRoute: Router().onGenerateRoute,
              navigatorKey: locator<NavigationService>().navigatorKey,
            );
          },
        );
      },
    );
  }
}

class ComponentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
        children: <Widget>[
//          Icons
          Column(
            children: <Widget>[
              Text(
                'Icons',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              //Icons
              Container(
                decoration: EcngTheme.cardDecoration,
                height: SizeConfig.heightMultiplier * 30,
                child: GridView.count(
                  crossAxisCount: 5,
                  children: <Widget>[
                    Container(child: Icon(Feather.search)),
                    Container(
                        child: Icon(MaterialCommunityIcons.filter_variant)),
                    Container(child: Icon(Ionicons.md_arrow_back)),
                    Container(child: Icon(FontAwesome5Solid.edit)),
                    Container(child: Icon(Feather.log_out)),
                    Container(child: Icon(Ionicons.md_home)),
                    Container(child: Icon(Icons.ondemand_video)),
                    Container(child: Icon(FontAwesome5Solid.search)),
                    Container(child: Icon(FontAwesome5Solid.user_circle)),
                    Container(child: Icon(Icons.photo)),
                    Container(child: Icon(FontAwesome5Solid.power_off)),
                    Container(child: Icon(FontAwesome5Solid.user_alt)),
                    Container(child: Icon(Icons.dashboard)),
                    Container(child: Icon(Icons.favorite_border)),
                    Container(child: Icon(FontAwesome.history)),
                    Container(child: Icon(Feather.settings)),
                    Container(child: Icon(Feather.star)),
                    Container(child: Icon(Icons.cancel)),
                    Container(
                      child: Icon(
                        Ionicons.logo_facebook,
                        color: EcngColors.facebookColor,
                      ),
                    ),
                    Container(
                      child: Icon(
                        FontAwesome.google_plus_square,
                        color: EcngColors.googleColor,
                      ),
                    ),
                  ],
                ),
              ),
              //other components
            ],
          ),
//          other components
          Column(
            children: <Widget>[
              Text(
                'Other Components',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Container(
                decoration: EcngTheme.cardDecoration,
                height: SizeConfig.heightMultiplier * 30,
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(SizeConfig.sizeMultiplier),
                      child: Row(
                        children: <Widget>[
                          OptionSelector(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
