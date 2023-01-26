import 'package:flutter/material.dart';
import 'package:timeitapp/widgets/message_widget.dart';

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
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: MessageWidget(messages[index]),
        );
      },
    );
  }
}
