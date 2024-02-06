import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:udemy_chat_app/widgets/components/chat_message.dart';
import 'package:udemy_chat_app/widgets/components/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> setupPushNotifications() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    final token = await fcm.getToken();

    print('**************');
    print('トークン: ${token}');
  }

  @override
  void initState() {
    super.initState();
    final FirebaseMessaging messageClient = FirebaseMessaging.instance;
    messageClient.requestPermission();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.exit_to_app,
                color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessages()
          ],
        ),
      ),
    );
  }
}
