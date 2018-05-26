import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:pub_semver/pub_semver.dart';

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
          return _buildLanding();
        } else if (_isUpdateToDate(snapshot.data)) {
          return new ConfigWrapper(snapshot.data);
        } else {
          return _buildUpdateView(context);
        }
      },
    );
  }

  bool _isUpdateToDate(RemoteConfig config) {
    final minVersion = new Version.parse(config.getString('min_support_version'));
    return minVersion <= semVer;
  }

  Widget _buildUpdateView(BuildContext context) {
    return new MaterialApp(
      supportedLocales: const <Locale>[const Locale('en', 'GB')],
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
        body: new AlertDialog(
          title: const Text('Update Required'),
          content: const Text(
            'Update is required, please update your app',
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('OK', style: const TextStyle(color: PrimaryColor),),
                onPressed: () { exit(0); }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanding() {
    return new MaterialApp(
      supportedLocales: const <Locale>[const Locale('en', 'GB')],
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

Future<RemoteConfig> _setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
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