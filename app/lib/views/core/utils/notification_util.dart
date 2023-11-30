// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUtil {
  static Future<String?> getFCMToken() async {
    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    return fcmToken;
  }

  static Future<void> delFCMToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }
}
