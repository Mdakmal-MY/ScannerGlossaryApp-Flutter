import 'package:flutter/foundation.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class AnalyticsProcessApi{
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  FirebaseAnalyticsObserver getAnalysticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);

  Future setUserProperties({@required String uid, String userRole}) async{
    await _analytics.setUserId(uid);
    await _analytics.setUserProperty(name: 'user_role', value: userRole);
  }

  Future logLogIn() async{
    await _analytics.logLogin(loginMethod: 'email');
  }

  Future logSignUp() async{
    await _analytics.logSignUp(signUpMethod: 'email');
  }

  Future logPostCreated({bool hasdata}) async{
    await _analytics.logEvent(name: "create_post",
    parameters: {'has_data': hasdata},);
  }
}