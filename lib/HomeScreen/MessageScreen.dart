import 'package:flutter/material.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key,required this.description});
final String description;
  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[400],
        title: Text(
          " Message Screen",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
body: Column(
  children: [
    Text(widget.description,style: TextStyle(
      fontSize: 15,
      color: Colors.black
    ),),
  ],
),
    );
  }
}
