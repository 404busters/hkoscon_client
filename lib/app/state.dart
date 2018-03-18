import 'package:flutter/material.dart';
import 'app.dart' show HKOSConClientApp;
import 'const.dart' show AppTitle, PrimaryColor, SecondaryColor;
import 'pages/home/page.dart' show HomePage;
import 'Container.dart' show AppContainer;

class HKOSConClientAppState extends State<HKOSConClientApp> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = new ThemeData(
      brightness: Brightness.light,
      primaryColor: PrimaryColor,
      accentColor: SecondaryColor,
    );
    return new MaterialApp(
      title: AppTitle,
      theme: theme,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new AppContainer(new HomePage()),
      },
    );
  }

}
