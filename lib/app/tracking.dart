import 'package:firebase_analytics/firebase_analytics.dart' show FirebaseAnalytics;

import 'router/history.dart' show HistoryEvent;

final FirebaseAnalytics analytics = new FirebaseAnalytics();

void firebaseHistorySubscriber(String action, HistoryEvent event) {
  analytics.setCurrentScreen(screenName: event.route);
}