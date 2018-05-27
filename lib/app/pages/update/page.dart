import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import '../../const.dart';

class UpdatePage extends StatelessWidget {
  final RemoteConfig config;

  const UpdatePage(this.config);

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
        body: new AlertDialog(
          title: const Text('Update Required'),
          content: new Text(
            'Please update your app to version ${config.getString('min_support_version')}',
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text(
                  'OK',
                  style: const TextStyle(color: PrimaryColor),
                ),
                onPressed: () { exit(0); }
            ),
          ],
        ),
      ),
    );
  }
}