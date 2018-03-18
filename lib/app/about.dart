import 'package:flutter/material.dart';
import 'const.dart' show Version;

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const AboutListTile(
      applicationName: 'HKOSCon Mobile',
      applicationVersion: Version,
    );
  }
}
