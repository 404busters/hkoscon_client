import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'const.dart';
import 'pages/home/page.dart' show HomePage;
import 'config.dart';

class HKOSConClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        if (!snapshot.hasData) {
          return new MaterialApp(
            supportedLocales: const <Locale>[const Locale('en', 'GB')],
            title: appDisplayTitle,
            theme: appTheme,
            home: new HomePage(),
          );
        }
        return new ConfigWrapper(snapshot.data);
      },
    );
  }
}

Future<RemoteConfig> _setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: false));
  remoteConfig.setDefaults(<String, dynamic>{
    'title_bar_text': 'HKOSCon',
    'timetable_endpoint': 'https://hkoscon.org/2018/data/timetable.json',
  });
  try {
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
  } catch (e) {
    debugPrint(e);
  }
  return remoteConfig;
}