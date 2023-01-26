import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InnerSearch extends StatelessWidget {
  final String docId;
  final String docIdDay;
  InnerSearch({
    super.key,
    required this.docId,
    required this.docIdDay,
  });

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db
          .collection(
              '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${docIdDay}/trabajadores/${docId}/jornadas')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('0h'),
          );
        }
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;
        print(docs);
        if (docs.isEmpty) {
          print("Is empty");
        }
        Duration diff = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int index = 0; index < docs.length; index++) {
          final doc = docs[index];
          DateTime now = DateTime.now();
          print(now);
          final startTime = (doc['startTime'] as Timestamp).toDate();
          print(startTime);
          if (doc['finished'] == true) {
            final finishTime = (doc['finishTime'] as Timestamp).toDate();
            diff = diff + finishTime.difference(startTime);
            print(diff);
          } else {
            diff = diff + now.difference(startTime);
          }
        }
        return Text('${diff}');
      },
    );
  }
}
