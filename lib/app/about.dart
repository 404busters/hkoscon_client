import 'package:flutter/material.dart';
import 'const.dart' show Version;

class AboutApp extends AboutListTile {
  AboutApp(): super(
    applicationName: 'HKOSCon',
    applicationVersion: Version,
  );
}
