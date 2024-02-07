


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_firebase/TriggerFunction.dart';

import 'HomeScreen/HomeScreen.dart';
import 'HomeScreen/MessageScreen.dart';
import 'NotificationServices.dart';
import 'firebase_options.dart'; // Import your NotificationServices class
// NotificationServices notificationServices = NotificationServices();
//
FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register the background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler );

  runApp(const MyApp());
}

var initializationSettingsAndroid =
AndroidInitializationSettings('@mipmap/ic_launcher');
var initializationSettings =
InitializationSettings(android: initializationSettingsAndroid);


// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationServices notificationServices = NotificationServices();

onTrigger();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );


  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print(message.data.toString());
  print(message.data['id']);

  // notificationServices.initLocalNotifications( message);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
