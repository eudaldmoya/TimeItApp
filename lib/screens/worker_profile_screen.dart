import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timeitapp/model/globals.dart' as globals;
import 'package:timeitapp/widgets/Log_out.dart';
import '../widgets/money_earned_list.dart';

class WorkerProfileScreen extends StatelessWidget {
  WorkerProfileScreen({super.key});

  final email = FirebaseAuth.instance.currentUser!.email;
  var username = FirebaseFirestore.instance
      .doc(
          '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Worker Profile')),
      body: Stack(
        children: [
          LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Image.asset('assets/back2.png',
                fit: BoxFit.cover, width: constraints.maxWidth);
          }),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: CircleAvatar(radius: 80),
                ),
                StreamBuilder(
                  stream: username,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.hasError) {
                      return ErrorWidget(snapshot.error.toString());
                    }
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final doc = snapshot.data!;
                    final name =
                        '${doc['name']} ${doc['firstSurname']} ${doc['secondSurname']}';
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 16),
                      child: Text(
                        '${name}',
                        style: TextStyle(fontSize: 26),
                      ),
                    );
                  },
                ),
                Text(
                  '${email}',
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      decoration: TextDecoration.underline),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .doc('/Company/kGCOpHgRyiIYLr4Fwuys')
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

                    final doc = snapshot.data!;
                    final name = doc['companyName'];
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${name}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                MoneyEarned(),
                SizedBox(
                  height: h * 0.1,
                ),
                LogOut(w, h)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatedMoney extends StatelessWidget {
  final docId;
  CalculatedMoney({super.key, required this.docId});

  Future<DocumentSnapshot> getPriceHour() async {
    return FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    num segundos;
    num hours;
    num minutes = 0;

    final db = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: db
          .collection(
              '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${docId}/trabajadores/${FirebaseAuth.instance.currentUser!.uid}/jornadas')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('0€'),
          );
        }
        final querySnap = snapshot.data!;
        final docs = querySnap.docs;
        Duration diff = Duration(hours: 0, minutes: 0, seconds: 0);
        for (int index = 0; index < docs.length; index++) {
          final doc = docs[index];
          DateTime now = DateTime.now();
          // print(now);
          final startTime = (doc['startTime'] as Timestamp).toDate();
          // print(startTime);
          if (doc['finished'] == true) {
            final finishTime = (doc['finishTime'] as Timestamp).toDate();
            diff = diff + finishTime.difference(startTime);
            //   print(diff);
          } else {
            diff = diff + now.difference(startTime);
          }
          segundos = diff.inSeconds / 60;
          hours = diff.inHours * 60;
          minutes = diff.inMinutes + segundos + hours;

          print('EL DIFF VALE $minutes');
          print('SUPERIOR VALE ${globals.superior}');
          if (minutes > globals.superior) {
            globals.superior = minutes;
            print("VALE en el if ${globals.superior}");
          }
          print('EL SUPERIOR ES ${globals.superior}');
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('/Company/kGCOpHgRyiIYLr4Fwuys/User/')
                .doc('${FirebaseAuth.instance.currentUser!.uid}')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot.error.toString());
              }
              if (!snapshot.hasData) {
                print("NO TIENE DATA");
                return Center(
                  child: Text('0h'),
                );
              }
              double w = MediaQuery.of(context).size.width;
              double h = MediaQuery.of(context).size.height;
              final querySnap = snapshot.data!;
              double porcentaje = (minutes / globals.superior) * 100;
              // print(querySnap);

              //return Text("hola");

              print('EL PORCENTAJE ES ${porcentaje}');
              return Row(
                children: [
                  LinearPercentIndicator(
                    width: w * 0.44,
                    lineHeight: h * 0.03,
                    percent: porcentaje / 100,
                    barRadius: const Radius.circular(30),
                    backgroundColor: Colors.grey,
                    progressColor: Color.fromARGB(255, 57, 67, 156),
                  ),
                  SizedBox(width: 50),
                  Text('${minutes * querySnap['priceHour']} €'),
                ],
              );
            }); //Text('${diff}');
      },
    );
  }
}
