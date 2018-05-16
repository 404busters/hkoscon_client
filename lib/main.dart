import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'app/app.dart';

void main() {
  FirebaseAnalytics analytics = new FirebaseAnalytics();
  analytics.logAppOpen();
  return runApp(new HKOSConClientApp());
}
