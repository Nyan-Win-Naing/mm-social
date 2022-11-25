import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() {
    return _singleton;
  }

  FCMService._internal();

  /// Firebase Messaging Instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> getFcmToken() async {
    String fcmToken = await messaging.getToken() ?? "";
    return Future.value(fcmToken);
  }
}