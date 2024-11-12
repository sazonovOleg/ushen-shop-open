import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsProxy {
  FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

  static const String _appOpen = 'app_open';
  static const String _openShop = 'open_shop';

  void _logEvent(String eventName) {
    firebaseAnalytics.logEvent(name: eventName);
  }

  void logAppOpen() {
    _logEvent(_appOpen);
  }

  void logOpenShop() {
    _logEvent(_openShop);
  }
}
