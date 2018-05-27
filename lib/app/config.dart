import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'const.dart';
import 'pages/schedule/page.dart';


final routes = <String, WidgetBuilder> {
  '/schedule': (BuildContext context) => new SchedulePage(),
};

class ConfigWrapper extends StatefulWidget {
  const ConfigWrapper(this.config);

  final RemoteConfig config;
  @override
  State<StatefulWidget> createState() => ConfigState(this.config);
}

class ConfigState extends State<ConfigWrapper> {
  final RemoteConfig config;
  ConfigState(this.config);
  
  static ConfigState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<ConfigState>());
  }

  static RemoteConfig remoteConfig(BuildContext context) {
    return ConfigState.of(context).config;
  }

  Future<bool> refresh() async {
    await this.config.fetch();
    return this.config.activateFetched();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: supportedLocales,
      title: appDisplayTitle,
      routes: routes,
      theme: appTheme,
      home: new SchedulePage(),
    );
  }
}
