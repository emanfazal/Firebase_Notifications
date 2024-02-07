import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../NotificationServices.dart';
import '../NotifyButton.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();



}

class _HomeBodyState extends State<HomeBody> {
  NotificationServices notificationServices = NotificationServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Text("Send Notifications",style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,

            ),),
          ),
        ),
        Center(child: NotifyButton()),
        SizedBox(height: 30,),
        TextButton(onPressed: (){
          notificationServices.getDeviceToken().then((value)async {
            var data={
              'to':value.toString(),
              'priority':'high',
'notification':{
  'title':'Notification sent from Eman',
  'body':'This is Flutter Notification',
},
              'data':{
                'type':'msg',
                'id':'eman123',
              }

            };
await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
  body: jsonEncode(data),
  headers: {
  'Content-Type':'application/json; charset=UTF-8',
  'Authorization' : 'key=AAAAv38Ku1o:APA91bGFxsw5HxCqZB5op-lVUzl6LFO6ZXFGFbinTNlgCc3uSq6JyibB82L2WV4F_7FYdlsyGXRRFZXXyBkXg9l53W1Qy5k1Ea1OvmZjX_rQcXXCwcH1VzbTMNkMxmcLMWaLvzq_tp4B'
  }

);
          });

        }, child: Text('Send Notification to other deivce',
          style: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.black,
            fontSize: 15,
        ),),)
      ],
    );
  }
}
