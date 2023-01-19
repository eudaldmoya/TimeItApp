import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                          final name = doc['name'];
                          final surname1 = doc['firstSurname'];
                          bool isWorking = doc['atWork'];

                          final today = DateTime.now();

                          CollectionReference _daysCollection =
                              FirebaseFirestore.instance.collection(
                                  '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays');

                          Future<void> getData() async {
                            // Get docs from collection reference
                            QuerySnapshot querySnapshot =
                                await _daysCollection.get();
                            // Get data from docs and convert map to List
                            final allData = querySnapshot.docs
                                .map((doc) => doc.data())
                                .toList();
                            //for (final day in allData) {
                            //if(day['workingDate']) {

                            //}
                            //}
                          }

                          return ListTile(
                              leading: CircleAvatar(),
                              title: Text("$name $surname1"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('h'),
                                  SizedBox(width: 5),
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
