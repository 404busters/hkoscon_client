import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart' show FirebaseAnalytics;
import 'package:firebase_analytics/observer.dart' show FirebaseAnalyticsObserver;

import 'app.dart' show HKOSConClientApp;
import 'const.dart' show AppTitle, PrimaryColor, SecondaryColor;
import 'pages/home/page.dart' show HomePage;
import 'Container.dart' show AppContainer;

class HKOSConClientAppState extends State<HKOSConClientApp> {

  final FirebaseAnalytics analytics = new FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: this.analytics);
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
      navigatorObservers: [
        observer,
      ],
    );
  }

}
