
import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    Key? key,
    required this.messages,
  });

  final List<Message> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        // final doc = docs[index];
        return ListTile(
          title: Text(messages[index].text),
          subtitle: Text(messages[index].datetime.toString()),
        );
      },
    );
  }
}
