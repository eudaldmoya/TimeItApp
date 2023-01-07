import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase WhatsApp")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/Company/kGCOpHgRyiIYLr4Fwuys/Chat')
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final qsnap = snapshot.data!;
          final docs = qsnap.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              return ListTile(
                title: Text(doc['name']),
              );
            },
          );
        },
      ),
    );
  }
}
