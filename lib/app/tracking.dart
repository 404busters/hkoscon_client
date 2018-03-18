import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

final FirebaseAnalytics analytics = new FirebaseAnalytics();
final FirebaseAnalyticsObserver observer = new FirebaseAnalyticsObserver(analytics: analytics);