import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:timeitapp/model/globals.dart' as globals;
import 'package:timeitapp/widgets/contar_dias.dart';
import 'package:timeitapp/widgets/mensaje_superior_escaner.dart';

class Scan_Screen extends StatefulWidget {
  const Scan_Screen({super.key});

  @override
  State<Scan_Screen> createState() => _Scan_ScreenState();
}

class _Scan_ScreenState extends State<Scan_Screen> {
  bool atWork = false;
  bool iniciar = false;
  bool confirmacion = false;
  bool puedeEscanear = true;

  final dbb = FirebaseFirestore.instance;
  final userPath =
      '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}';
  Future<void> updateAtWork() async {
    await dbb.doc(userPath).update({
      'atWork': atWork,
    });
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    final String id = FirebaseAuth.instance.currentUser!.uid.toString();
    timer = Timer.periodic(
        Duration(seconds: 1), (Timer t) => checkForNewSharedLists());

    FirebaseFirestore.instance
        .collection('/Company/kGCOpHgRyiIYLr4Fwuys/User/')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        dynamic nested = documentSnapshot.get(FieldPath(['atWork']));
        print('Document data: ${nested}');
        atWork = nested;
        print('Document data: atwork $atWork');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkForNewSharedLists() {
    globals.connected = false;
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 207, 207, 242),
        body: Center(
          child: StreamBuilder(
            stream: db.doc('/Company/kGCOpHgRyiIYLr4Fwuys').snapshots(),
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

              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: MobileScanner(
                            allowDuplicates: false,
                            onDetect: (barcode, args) {
                              if (barcode.rawValue == null) {
                                debugPrint('Failed to scan Barcode');
                              } else {
                                final String code = barcode.rawValue!;
                                if (puedeEscanear) {
                                  if (doc['qrId'] == code) {
                                    globals.can = true;

                                    iniciar = true;

                                    puedeEscanear = false;
                                  } else {
                                    print("NO ES EL CORRECTO BRO");
                                  }
                                }
                              }
                            }),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .doc(
                                  '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.hasError) {
                              return ErrorWidget(snapshot.error.toString());
                            }
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            final doca = snapshot.data!;

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color:
                                          Color.fromARGB(255, 178, 178, 233)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 20, right: 20),
                                    child: Text(
                                      'Buenas ${doca['name']}!',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 38, 45, 109),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color:
                                          Color.fromARGB(255, 178, 178, 233)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 20, right: 20),
                                    child: atWork
                                        ? Text("Estás trabajando")
                                        : Text(
                                            "Ahora mismo no estás trabajando"),
                                  ),
                                ),
                                Expanded(
                                  child: globals.connected
                                      ? ContarDias(atWork: atWork)
                                      : Text(""),
                                ),
                                ElevatedButton(
                                  onPressed: globals.can
                                      ? () {
                                          globals.connected = true;
                                          globals.can = false;
                                          atWork = !atWork;
                                          confirmacion = !confirmacion;
                                          puedeEscanear = true;
                                          updateAtWork();
                                        }
                                      : null,
                                  child: confirmacion
                                      ? Text("Confirmar salida")
                                      : Text("Confirmar entrada"),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  MensajeSuperiorRecordatorioEscaneo(atWork: atWork),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
