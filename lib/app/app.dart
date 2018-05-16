import 'package:flutter/material.dart';

import 'const.dart' show AppTitle;
import 'theme.dart' show AppTheme;

import 'pages/schedule/page.dart' show SchedulePage;


class HKOSConClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: AppTitle,
        theme: AppTheme,
        home: new SchedulePage(),
    );
  }
}