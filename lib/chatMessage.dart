import 'package:chatter_ai/constants.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.text, required this.sender});
  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Align the icon to the top
      children: [
        Container(
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(
            child: Text(
              sender[0],
              style: avatarText,
            ),
            backgroundColor: sender == "user" ? Colors.blue : Colors.green,
            radius: 22.0,
          ),
        ),
        Flexible(
          child: Wrap( // Use Wrap to allow content to wrap
            crossAxisAlignment: WrapCrossAlignment.start, // Align children to the start
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: sender == "user" ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
