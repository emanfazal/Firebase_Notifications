import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notifications_firebase/HomeScreen/HomeBody.dart';
import 'package:notifications_firebase/NotificationServices.dart';
import 'package:notifications_firebase/NotifyButton.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();

    notificationServices.RequestNotificatonPermission();
    notificationServices.FirebaseInit(context);
    notificationServices.IstokenResfresh();
    notificationServices.SetupinteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("Device Token");
      print(value);
    });




    // notificationServices.initLocalNotifications(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
          " FireBase Notifications App",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      body: HomeBody(),
    );
  }
}


void _triggerNotification() async {
  // Create a sample message
  RemoteMessage message = RemoteMessage(
    data: {
      'id': '1',
      'type': 'msg',
    },
    notification: RemoteNotification(
      title: '',
      body: 'Sample Body',
    ),
  );}
