import 'package:chatter_ai/constants.dart';
import 'package:flutter/material.dart';
class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});
  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(child: Text(sender[0], style: avatarText,) , 
          backgroundColor:avatarColor,
          radius: 22.0,),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: TextStyle(color: Colors.white, fontSize: 22.0),),
        ],)
      ],
    );
  }
}