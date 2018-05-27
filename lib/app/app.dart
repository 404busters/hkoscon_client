import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pub_semver/pub_semver.dart';

import 'const.dart';
import 'pages/landing/page.dart';
import 'pages/update/page.dart';
import 'config.dart';

class HKOSConClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: _setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<RemoteConfig> snapshot) {
        if (!snapshot.hasData) {
          return const LandingPage();
        } else if (_isUpdateToDate(snapshot.data)) {
          return new ConfigWrapper(snapshot.data);
        } else {
          return new UpdatePage(snapshot.data);
        }
      },
    );
  }

  bool _isUpdateToDate(RemoteConfig config) {
    final minVersion = new Version.parse(
        config.getString('min_support_version'),
    );
    return minVersion <= semVer;
  }
}

Future<RemoteConfig> _setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: false));
  remoteConfig.setDefaults(<String, dynamic>{
    'title_bar_text': 'HKOSCon',
    'timetable_endpoint': 'https://hkoscon.org/2018/data/timetable.json',
    'min_support_version': appVersion,
  });
  try {
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
  } catch (e) {
    debugPrint(e);
  }
  return remoteConfig;
}