import 'package:cloud_firestore/cloud_firestore.dart';
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
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Material(
            color: Colors.pink,
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
                    style: TextStyle(
                        fontSize: 9, color: Color.fromARGB(255, 223, 222, 222)),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      print("hola");
      print(FirebaseAuth.instance.currentUser!.uid);
      return Row(
        children: [
          Material(
              elevation: 1,
              borderRadius: BorderRadius.all(Radius.circular(3)),
              child: Column(
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .doc(
                            '/Company/kGCOpHgRyiIYLr4Fwuys/User/${msg.userId}')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) { if (snapshot.hasError) {
              return ErrorWidget(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final doca = snapshot.data!;
            
            return Text(doca['name']);
            
            
            },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: Text(
                          msg.text,
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: Text(
                          msg.hhmm,
                          style: TextStyle(
                              fontSize: 9,
                              color: Color.fromARGB(255, 117, 117, 117)),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      );
    }
  }
}
