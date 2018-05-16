import 'package:flutter/material.dart';

import 'const.dart' show AppTitle;
import 'theme.dart' show AppTheme;

import 'container.dart' show AppContainer;
import 'router/router.dart' show ContainerBuilder, Router;
import 'pages/schedule/page.dart' show SchedulePage;

final routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new SchedulePage(),
  '/schedule': (BuildContext context) => new SchedulePage(),
};

final ContainerBuilder builder = (BuildContext context, Widget child) => new AppContainer(child);

class HKOSConClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = new Router(
      routes: routes,
      builder: builder,
    );

    final navigator = new Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings setting) {
          return new PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => router,
          );
        }
    );


    return new MaterialApp(
        title: AppTitle,
        theme: AppTheme,
        home: navigator,
    );
  }
}