import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeitapp/model/message.dart';
import 'package:timeitapp/widgets/db.dart' as db;
import 'package:timeitapp/widgets/message_box.dart';

import '../widgets/message_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      backgroundColor: Color.fromARGB(255, 207, 207, 242),
      body: StreamBuilder(
        stream: db.getGroupMessages(),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

         

          return Stack(
            children: [
              LayoutBuilder(builder: (context, BoxConstraints constraints) {
                return Image.asset('assets/back2.png',
                    fit: BoxFit.cover, width: constraints.maxWidth);
              }),
              Column(
                children: [
                  Expanded(
                    child: MessageList(messages: snapshot.data!),
                  ),
                  MessageBox(onSend: (text) {
                    final User = FirebaseAuth.instance.currentUser!.uid;
                
                    final message = Message(text, User);
                    db.sendMessage(message);
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
