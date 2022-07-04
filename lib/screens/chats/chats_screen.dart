import 'package:flutter/material.dart';
import 'package:gapo_project/screens/chats/chats.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: const [
          HeaderChats(),
          SizedBox(height: 20,),
          SearchChats(),
        ],
      ),
    );
  }
}
