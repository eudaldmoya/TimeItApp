import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(this.msg);
  
  final Message msg;

  @override
  Widget build(BuildContext context) {
    if (msg.userId == FirebaseAuth.instance.currentUser!.uid) {
      return Row(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Color.fromARGB(255, 92, 1, 68),
                elevation: 1,
                borderRadius: BorderRadius.all(Radius.circular(3)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Text(
                        msg.text,
                        style: TextStyle(fontSize: 13, color: Colors.white),
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
          ),
        ],
      );
    }

    else{
      print ("hola");
      print(FirebaseAuth.instance.currentUser!.uid);
      return Row(
        children: [
          Material(
              elevation: 1,
              borderRadius: BorderRadius.all(Radius.circular(3)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      msg.text,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: Text(
                      msg.hhmm,
                      style: TextStyle(fontSize: 9, color: Color.fromARGB(255, 255, 0, 0)),
                    ),
                  ),
                ],
              )),
        ],
      );
    }
  }
}
