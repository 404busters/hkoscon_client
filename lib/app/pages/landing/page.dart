import 'package:flutter/material.dart';
import '../../const.dart';
import '../home/page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: supportedLocales,
      title: appDisplayTitle,
      theme: appTheme,
      home: new Scaffold(
        appBar: new AppBar(
          elevation: 4.0,
          title: new Text(
              'HKOSCon',
              style: const TextStyle(
                color: SecondaryColor,
                fontFamily: 'Open Sans',
              )
          ),
        ),
        body: new HomePage(),
      ),
    );
  }
}
