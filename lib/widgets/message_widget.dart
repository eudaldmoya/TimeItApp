import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(this.msg);

  final Message msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
            elevation: 1,
            borderRadius: BorderRadius.all(Radius.circular(3)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    msg.text,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2),
                  child: Text(
                    msg.hhmm,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
