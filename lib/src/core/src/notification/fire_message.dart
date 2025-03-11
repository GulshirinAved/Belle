import 'dart:developer' show log;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FireMessage {
  final _firebaseInstance = FirebaseMessaging.instance;

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    // id
    'high_importance_channel',
    // title
    'High Importance Notifications',
    // description
    description: 'This channel is used for important notifications.',
    importance: Importance.defaultImportance,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String?> getToken([String? token]) async {
    return await _firebaseInstance.getToken();
  }

  Future<void> deleteToken() async {
    return await _firebaseInstance.deleteToken();
  }

  void _setOnMessageConfig(
    void Function(Map<String, dynamic>) onMessageReceived,
    void Function(Map<String, dynamic>) onMessageOpenedApp,
  ) async {
    log('START: setting up local notification');

    await _setupLocalNotification();
    log('DONE: setting up local notification');

    NotificationSettings settings = await _firebaseInstance.requestPermission();
    log('User granted permission: ${settings.authorizationStatus}');

    log('START: setting up Firebase onMessage');

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('${message.data.runtimeType}');
      final notification = message.notification;
      final android = message.notification?.android;
      final notificationMap = message.data;

      log('notification: $notification');
      log('android: $android');
      onMessageOpenedApp(notificationMap);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('${message.data}');
      final notification = message.notification;
      final android = message.notification?.android;

      final notificationMap = message.data;

      log('notification: $notification');
      log('android: $android');
      //
      // // If `onMessage` is triggered with a notification, construct our own
      // // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                _channel.id,
                _channel.name,
                channelDescription: _channel.description,
                // other properties...
              ),
            ));
      }
      onMessageReceived(notificationMap);
    });
  }

  Future<void> _setupLocalNotification() async {
    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          )),
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  Future<void> subscribeToTopic(String topic) async {
    return await _firebaseInstance.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    return await _firebaseInstance.unsubscribeFromTopic(topic);
  }

  void init(void Function(Map<String, dynamic>) onMessageReceived,
      void Function(Map<String, dynamic>) onMessageOpenedApp) {
    _setOnMessageConfig(onMessageReceived, onMessageOpenedApp);
  }
}
