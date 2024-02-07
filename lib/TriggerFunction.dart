import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> onTrigger() async {
  var androidInitialization =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (payload) {

      }
  );
  Future<void> _showNotification() async {

    // await _flutterLocalNotificationsPlugin.initialize(
    //     onDidReceiveBackgroundNotificationResponse: (payload) {
    //
    //     });
    // Initialize the settings for Android
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin with the initialization settings

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (String? payload) async {
      //   // Handle when notification is tapped
      //   print('Notification tapped');
      // },
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Display the notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Notification Title',
      'This is a notification message',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );

  }

  }





