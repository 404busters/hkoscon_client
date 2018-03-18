import 'package:flutter/material.dart';

import 'app.dart' show HKOSConClientApp;
import 'const.dart' show AppTitle;
import 'Container.dart' show AppContainer;
import 'theme.dart';
import 'router/router.dart';
import 'pages/home/page.dart';

class HKOSConClientAppState extends State<HKOSConClientApp> {

  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      '/': (BuildContext context) => new HomePage(),
    };

    ContainerBuilder builder = (BuildContext context, Widget child) => new AppContainer(child);

    var router = new Router(routes, builder);

    return new MaterialApp(
      title: AppTitle,
      theme: AppTheme,
      home: router
    );

  }

}
