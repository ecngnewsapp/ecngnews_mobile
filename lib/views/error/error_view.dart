import 'package:ecngnews/utils/size_config.dart';
import 'package:ecngnews/views/error/error_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErrorViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: (Container(
                  padding: EdgeInsets.all(SizeConfig.sizeMultiplier * 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Opps we have an error',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: model.refresh,
                        child: Icon(
                          Icons.refresh,
                          size: SizeConfig.sizeMultiplier * 10,
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ),
        viewModelBuilder: () => ErrorViewModel());
  }
}
