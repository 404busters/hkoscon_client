import 'package:flutter/material.dart';

import 'const.dart' show AppTitle;
import 'theme.dart' show AppTheme;

import 'container.dart' show AppContainer;
import 'router/router.dart' show ContainerBuilder, Router;
import 'pages/home/page.dart' show HomePage;

class HKOSConClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      '/': (BuildContext context) => new HomePage(),
    };

    ContainerBuilder builder = (BuildContext context, Widget child) => new AppContainer(child);

    var router = new Router(
      routes: routes,
      builder: builder,
    );

    return new MaterialApp(
        title: AppTitle,
        theme: AppTheme,
        home: router
    );

  }
}