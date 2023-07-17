import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:chatter_ai/constants.dart';
import 'package:chatter_ai/chatMessage.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart'as http;

import 'api_key.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _Textcontroller = TextEditingController();
  final List<ChatMessage> _message = [];
  late OpenAI openAI;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void sendMessage() async {
    ChatMessage message = ChatMessage(text: _Textcontroller.text, sender: 'user');
    setState(() {
      _message.insert(0, message);
    });
    sendMessagetoChatGpt(message.text);

    _Textcontroller.clear();

    String response= await sendMessagetoChatGpt(message.text);
    ChatMessage chatgpt= ChatMessage(text: response, sender: "ChatGPT");
    setState(() {
      _message.insert(0, chatgpt);
    });

  }
  Future <String> sendMessagetoChatGpt(String message) async{
    Uri uri= Uri.parse("https://api.openai.com/v1/chat/completions");
    Map<String , dynamic> body=
      {
  "model": "gpt-3.5-turbo",
  "messages": [{"role": "system", "content": message}, 
      ],
      "max_tokens":500,
      };
      final response=await http.post(uri,
      headers: {
        "Content-Type":"application/json",
        "Authorization":"Bearer ${API_Key.api_key}",
      },
      body: json.encode(body),
      );
      print(response.body);
      Map<String , dynamic> parsedResponse= json.decode(response.body);
      String reply= parsedResponse['choices'][0]['message']['content'];
     return reply;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatGPT BOT'),
        backgroundColor: const Color.fromARGB(255, 54, 51, 51),
        centerTitle: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 34, 33, 33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 9,
              child: ListView.builder(
                reverse: true,
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  return _message[index];
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 12.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => sendMessage(),
                      controller: _Textcontroller,
                      style: inputtextstyle,
                      decoration: InputDecoration(
                        hintText: 'Enter your text here...',
                        hintStyle: hinttextstyle,
                        filled: true,
                        fillColor: Color.fromARGB(255, 75, 71, 71),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: sendMessage,
                          icon: Icon(Icons.send, color: Color.fromARGB(255, 17, 236, 25), size: 30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}