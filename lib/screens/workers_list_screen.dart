import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/widgets/db.dart' as dbWork;
import '../model/dia.dart';
import '../model/workers_work.dart';
import '../widgets/hours_worked_today.dart';

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

//__________________________________________________________________________________________________________________
//________________________________________________________________________________________________________________
//__________________________________________________________HEEEEEY_______________________________________________________________}
//__________________________________________________________________________________________________________________
//_________________________________________________________________________________________________________________



