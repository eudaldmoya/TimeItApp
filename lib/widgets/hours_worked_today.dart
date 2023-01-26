import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'inner_hours_worked_today.dart';

class HoursWorkedToday extends StatelessWidget {
  final String docId;
  HoursWorkedToday({
    super.key,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db
          .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
          .orderBy('workingDate', descending: true)
          .limit(1)
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
        print("Está entrando a este WIDGETOOOOO");
        print('EN TOTAL NO HAY ${docs.length}');

        final doc = docs[0];

        DateTime today = DateTime.now();
        String dateStr = "${today.day}-${today.month}-${today.year}";
        final date = (doc['workingDate'] as Timestamp).toDate();
        final dateFire =
            '${date.day.toString()}-${date.month.toString()}-${date.year.toString()}';
        print('${dateStr} ${dateFire}');
        int comprobacion = 0;
        if (dateFire == dateStr) {
          comprobacion++;
          print("tiene la misma fecha");
        }

        if (comprobacion == 1) {
          final String docIdDay = doc.id;
          print(docIdDay);
          print(docId);
          return InnerSearch(
            docId: docId,
            docIdDay: docIdDay,
          );
        } else {
          return Text('0h');
        }
      },
    );
  }
}
