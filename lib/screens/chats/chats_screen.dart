import 'package:base_flutter/screens/chats/chats_controller.dart';
import 'package:base_flutter/screens/chats/widgets/chats_body.dart';
import 'package:base_flutter/screens/chats/widgets/header.dart';
import 'package:base_flutter/screens/chats/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatsScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsController());
  }
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ChatsController chatsController = Get.find();

  @override
  void initState() {
    chatsController.initChats();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: const [
            HeaderChats(),
            SizedBox(height: 20,),
            SearchChats(),
            SizedBox(height: 5,),
            ChatsBody()
          ],
        ),
      ),
    );
  }
}
