
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'HomeScreen/MessageScreen.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

//Initialize Notification Function
  void initLocalNotifications(BuildContext context,RemoteMessage message ) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();
    var initializeSetting = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializeSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {
      handleMessage(context,message);
        });
  }

//FireBase Initialization notification function
  void FirebaseInit(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {


        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
        print('Data: ${message.data.toString()}');
        print('ID: ${message.data['id']}');
        print('message: ${message.data['type']}');

        print("EMAN");
        if(Platform.isAndroid){
          initLocalNotifications(context,message);
          showNotification(message);
        }



    });


    // Handle notification received when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

        print('Title: ${message.notification!.title}');
        print('Body: ${message.notification!.body}');
        print(message.data.toString());
        print(message.data['id']);

print(message.data['type']);

    });
  }


  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'channel_id', // Use a constant channel ID
      'High Priority Notifications',
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'Ticker',
    );

    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentList: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    // Show the notification
    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails,
    );
  }
  //handling messages:
void handleMessage(BuildContext context,RemoteMessage message){
if(message.data['type']=='msg'){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageScreen(description: message.data['description'],)));}


}
//when app is terminated
Future<void> SetupinteractMessage(BuildContext context)async{

RemoteMessage? initialMessage=await FirebaseMessaging.instance.getInitialMessage();
if(initialMessage!=null){
handleMessage(context, initialMessage);
}
FirebaseMessaging.onMessageOpenedApp.listen((event) {
  handleMessage(context, event);
});
}


  //Grant android and ios notification permission
  void RequestNotificatonPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      badge: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted provisional permission");
    } else {
      print("user denied permission");
    }
  }

  //Getting Device Tokens
  Future<String> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token ?? '';
  }

  //Refreshing Token
  void IstokenResfresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("Refresh");
    });
// try {
// // Code that may throw an exception
// } catch (e, stackTrace) {
// // Handle the exception
// print('Error: $e');
// print('Stack Trace: $stackTrace');
// }
}}


