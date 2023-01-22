import 'dart:async';
import 'package:timeitapp/model/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/widgets/contar_dias.dart';
import 'package:timeitapp/widgets/db.dart' as work;
import 'package:timeitapp/widgets/work_day.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({super.key});

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   bool atWork = false;
//   final db = FirebaseFirestore.instance;
//   final userPath = '/Company/kGCOpHgRyiIYLr4Fwuys/User/9owrui5NveI2u9XqgMxE';
//   Future<void> updateAtWork() async {
//     await db.doc(userPath).update({
//       'atWork': atWork,
//     });
//     setState(() {
//       atWork = !atWork;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final db = FirebaseFirestore.instance;
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//             child: StreamBuilder(
//           stream: db
//               .doc(
//                   '/Company/kGCOpHgRyiIYLr4Fwuys/User/CAloQhHUUqQK3ZGR8vjcl6FGQuA3')
//               .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//             if (snapshot.hasError) {
//               return ErrorWidget(snapshot.error.toString());
//             }
//             if (!snapshot.hasData) {
//               return const CircularProgressIndicator();
//             }

//             final doc = snapshot.data!;

//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   doc['name'],
//                   style: const TextStyle(fontSize: 32),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     updateAtWork();
//                   },
//                   icon: Icon(Icons.start),
//                   label: Text("Start"),
//                 ),
//                 doc['atWork'] ? Text('true') : Text('false')
//               ],
//             );
//           },
//         )),
//       ),
//     );
//   }
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             child: QRView(
//               key: qrKey,
//               onQRViewCreated: _onQRViewCreated,
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text(
//                       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   : Text('Scan a code'),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

//  Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mobile Scanner')),
//       body: MobileScanner(
//           allowDuplicates: false,
//           onDetect: (barcode, args) {
//             if (barcode.rawValue == null) {
//               debugPrint('Failed to scan Barcode');
//             } else {
//               final String code = barcode.rawValue!;
//               debugPrint('Barcode found! $code');
//             }
//           }),
//     );
//   }

class Scan_Screen extends StatefulWidget {
  const Scan_Screen({super.key});

  @override
  State<Scan_Screen> createState() => _Scan_ScreenState();
}

class _Scan_ScreenState extends State<Scan_Screen> {
  bool atWork = false;
  bool iniciar = false;

  final dbb = FirebaseFirestore.instance;
  final userPath =
      '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}';
  Future<void> updateAtWork() async {
    await dbb.doc(userPath).update({
      'atWork': atWork,
    });
    setState(() {
      atWork = !atWork;
    });
  }

  void llamar() {
    GroupJornada();
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        Duration(seconds: 5), (Timer t) => checkForNewSharedLists());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void checkForNewSharedLists() {
    // do request here

    globals.connected = false;
    // setState(() {
    //   iniciar = false;

    //   // change state according to result of request
    // });
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final puede = false;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Mobile Scanner')),
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

              return Column(
                children: [
                  Expanded(
                    child: MobileScanner(
                        allowDuplicates: false,
                        onDetect: (barcode, args) {
                          if (barcode.rawValue == null) {
                            debugPrint('Failed to scan Barcode');
                          } else {
                            final String code = barcode.rawValue!;
                            if (doc['qrId'] == code) {
                              globals.can = true;
                              // debugPrint('Barcode found! $code');
                              atWork = !atWork;
                              iniciar = true;
                              dbb.doc(userPath).update({
                                'atWork': atWork,
                              });

                              // ContarDias(atWork: atWork,);
                              
                            } else {
                              print("NO ES EL CORRECTO BRO");
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
                          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.hasError) {
                          return ErrorWidget(snapshot.error.toString());
                        }
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final doca = snapshot.data!;

                        return Column(
                          children: [
                            Text('Hola ${doca['name']}'),
                            Container(
                              child: atWork
                                  ? Text("Trabajando")
                                  : Text("No trabajando"),
                            ),
                            Expanded(
                              child: globals.connected
                                  ? ContarDias(atWork: atWork)
                                  : Text(
                                      "dataaa"), //HACER UN PROVIDER, DESDE ESTE WIDGET SE MODIFICARÁ, DESDE EL DE ABAJO TAMBIEN, PARA ASI PODERLO IR RETOCANDO DESDE LOS DOS LADOS
                              // iniciar ? ContarDias(atWork: atWork,) : Text("data"),
                            ),
                            ElevatedButton(
                              onPressed: globals.can
                                  ? () {
                                      globals.connected = true;
                                      globals.can = false;
                                      print("ESTA TRABAJ");
                                    }
                                  : null,
                              child: Text("Click para confirmar"),
                              
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: globals.can
          ? () {
              globals.connected = true;
              globals.can = false;

              ContarDias;
            }
          : null,
      child: Text("Click para confirmar"),
    );
  }
}
