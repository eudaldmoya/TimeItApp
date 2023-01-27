import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screens/worker_profile_screen.dart';

class MoneyEarned extends StatelessWidget {
  const MoneyEarned({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final db = FirebaseFirestore.instance;
    return Column(
      children: [
        StreamBuilder(
            stream: db
                .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
                .orderBy('workingDate', descending: true)
                .limit(5)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final qsnap = snapshot.data!;
              final docs = qsnap.docs;
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final docId = doc.reference.id;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Day ${index + 1}'),
                        SizedBox(width: 50),
                        Container(width: w*0.7, child: CalculatedMoney(docId: docId))
                      ],
                    ),
                  );
                },
              );
            })
      ],
    );
  }
}
