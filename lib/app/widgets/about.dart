import 'package:flutter/material.dart';
import '../const.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AboutListTile(
      applicationName: appDisplayTitle,
      applicationVersion: Version,
    );
  }
}
