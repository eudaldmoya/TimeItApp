import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeitapp/widgets/db.dart' as db;
import 'package:timeitapp/model/message.dart';
import 'package:timeitapp/widgets/message_box.dart';

import '../widgets/message_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase WhatsApp")),
      backgroundColor: Color.fromARGB(255, 250, 209, 223),
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

          // final docs = qsnap.docs;
          return Column(
            children: [
              Expanded(
                child: MessageList(messages: snapshot.data!),
              ),
              MessageBox(onSend: (text){
              
                db.sendMessage( Message(text));
              }),
            ],
          );
        },
      ),
    );
  }
}
