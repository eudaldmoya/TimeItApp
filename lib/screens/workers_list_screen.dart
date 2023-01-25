import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/widgets/db.dart' as dbWork;
import '../model/dia.dart';
import '../model/workers_work.dart';

class WorkersListScreen extends StatefulWidget {
  const WorkersListScreen({super.key});

  @override
  State<WorkersListScreen> createState() => _WorkersListScreenState();
}

class _WorkersListScreenState extends State<WorkersListScreen> {
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final userPath = '/Company/kGCOpHgRyiIYLr4Fwuys/User';
    return Scaffold(
        appBar: AppBar(title: Text("Workers")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(207, 207, 242, 0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Title(color: Colors.black, child: Text('Today')),
                ),
                StreamBuilder(
                    stream: db
                        .collection("/Company/kGCOpHgRyiIYLr4Fwuys/User")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
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
                          final name = doc['name'];
                          final surname1 = doc['firstSurname'];
                          bool isWorking = doc['atWork'];

                          final todayDay = DateTime.now().day.toString();
                          final todayMonthNum = DateTime.now().month;
                          final todayYear = DateTime.now().year.toString();
                          if (todayMonthNum < 10) {
                            final todayMonth = '0${todayMonthNum}';
                            print('${todayDay}-${todayMonth}-${todayYear}');
                          }

                          return ListTile(
                              leading: CircleAvatar(),
                              title: Text("$name $surname1"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HoursWorkedToday(docId: docId),
                                  const SizedBox(width: 15),
                                  Container(
                                    width: 10,
                                    decoration: BoxDecoration(
                                        color: isWorking == true
                                            ? Colors.purple
                                            : Colors.transparent,
                                        border: Border.all(
                                            color: isWorking == true
                                                ? Colors.purple
                                                : Colors.grey),
                                        shape: BoxShape.circle),
                                  )
                                ],
                              ));
                        },
                      );
                    }),
              ],
            ),
          ),
        ));
  }
}

class HoursWorked extends StatelessWidget {
  final String docId;
  HoursWorked({
    super.key,
    required this.docId,
  });

  CollectionReference _daysCollection = FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays');

  @override
  Widget build(BuildContext context) {
    return Text('hhh');
  }
}

//__________________________________________________________________________________________________________________
//________________________________________________________________________________________________________________
//__________________________________________________________HEEEEEY_______________________________________________________________}
//__________________________________________________________________________________________________________________
//_________________________________________________________________________________________________________________

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
          return Text('nope');
        }
      },
    );
  }
}

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
        Duration? diff;
        for (int index = 0; index < docs.length; index++) {
          final doc = docs[index];
          DateTime now = DateTime.now();
          print(now);
          final startTime = (doc['startTime'] as Timestamp).toDate();
          print(startTime);
          if (doc['finished'] == true) {
            final finishTime = (doc['finishTime'] as Timestamp).toDate();
            diff = finishTime.difference(startTime);
            print(diff);
          } else {
            // TODO: Acabar...
          }
        }
        return Text('${diff ?? ""}');
      },
    );
  }
}

class HW extends StatelessWidget {
  final String docId;
  HW({
    super.key,
    required this.docId,
  });

  CollectionReference colRef1 =
      FirebaseFirestore.instance.collection('workingDays');

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: colRef1
            .orderBy('workingDate', descending: true)
            .limit(1)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error.toString());
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> todayDoc =
              snapshot.data! as Map<String, dynamic>;
          return Text('y');
        },
      ),
    );
  }
}
