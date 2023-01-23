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
            color: Color.fromARGB(255, 57, 67, 156),
            elevation: 1,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
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
              color: Color.fromARGB(255, 207, 207, 242),
              elevation: 1,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .doc('/Company/kGCOpHgRyiIYLr4Fwuys/User/${msg.userId}')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasError) {
                        return ErrorWidget(snapshot.error.toString());
                      }
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final doca = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.only(left: 6, top: 6),
                        child: Text(
                          doca['name'],
                          style: TextStyle(
                            color: Color.fromARGB(255, 57, 67, 156),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
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
