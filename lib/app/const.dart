import 'dart:ui' show Color;
import 'package:flutter/material.dart';
import 'package:pub_semver/pub_semver.dart';

const String appDisplayTitle = 'HKOSCon';
const String AppTitle = 'HKOSCon 2018';
const supportedLocales = const <Locale>[const Locale('en', 'GB')];

const String appVersion = '2018.3.0';
final Version semVer = Version(2018, 3, 1);

const Color PrimaryColor = const Color(0xFF294454);
const Color SecondaryColor = const Color(0xFFF3CB02);
final ThemeData appTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: PrimaryColor,
  accentColor: SecondaryColor,
  backgroundColor: Colors.white,
);
