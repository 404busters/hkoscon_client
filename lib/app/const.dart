import 'dart:ui' show Color;
import 'package:flutter/material.dart' show ThemeData, Brightness;
const String appDisplayTitle = 'HKOSCon';
const String AppTitle = 'HKOSCon 2018';
const String Version = '2018.3.0';
const Color PrimaryColor = const Color(0xFF294454);
const Color SecondaryColor = const Color(0xFFF3CB02);

final ThemeData appTheme = new ThemeData(
  brightness: Brightness.light,
  primaryColor: PrimaryColor,
  accentColor: SecondaryColor,
);
