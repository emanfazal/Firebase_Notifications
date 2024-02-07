import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class NotifyButton extends StatelessWidget {
  const NotifyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.pink[80],
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.pink[50], // Set the background color here
        ),
        onPressed: () {
          // Call the _showNotification function when the button is pressed
          _showNotification();
        },
        child: Text('Press Button'),
      ),
    );
  }

  // Define _showNotification function
  Future<void> _showNotification() async {
    // Initialize the settings for Android
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    // Initialize the plugin with the initialization settings
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
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
    await _flutterLocalNotificationsPlugin.show(
      0,
      'FireBase Notification',
      'Hello!',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }
}

