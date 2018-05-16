import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'app/app.dart';

void main() {
  FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  FirebaseAnalytics analytics = new FirebaseAnalytics();
  analytics.logAppOpen();
  return runApp(new HKOSConClientApp());
}
