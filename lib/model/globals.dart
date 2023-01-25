library my_prj.globals;

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

late final StreamSubscription myStream;
//typedef int inicioAtWork(bool atWork);
bool can = false;
bool connected = false;

 bool atWork = false;

final userPath =
    '/Company/kGCOpHgRyiIYLr4Fwuys/User/${FirebaseAuth.instance.currentUser!.uid}';



Future inicioAtWork() async {
  final String id = FirebaseAuth.instance.currentUser!.uid.toString();

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


  // print("estoy entrando");
  // // DocumentReference collectionReference =
  // //     FirebaseFirestore.instance.doc(userPath);

  // // collectionReference.get().then(
  // //       ((value) {
  // //           final doc = value.data();
  // //           atWork = doc?['atWork'] ?? false;

  // //       }),
  // //     );

  // final String id = FirebaseAuth.instance.currentUser!.uid.toString();
  // CollectionReference users = FirebaseFirestore.instance
  //     .collection('/Company/kGCOpHgRyiIYLr4Fwuys/User/');

  // return FutureBuilder<DocumentSnapshot>(
    
  //   future: users.doc(id).get(),
  //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //     if (snapshot.hasError) {
  //       print("Something went wrong");
  //       return Text("Something went wrong");
  //     }

  //     if (snapshot.hasData && !snapshot.data!.exists) {
  //       print("Document does not exist");
  //       return Text("Document does not exist");
  //     }

  //     if (snapshot.connectionState == ConnectionState.done) {
  //       print("DOCUMENTO ESTÁ LISTO");
  //       final doc = snapshot.data!;
  //       atWork = doc['atWork'];
  //       print("ey");

       
  //       return Text("");
  //     }
  //     print("DOCUMENTO PASADOO");

  //     return Text("loading");
  //   },
  // );

  // print("object MIAU");

  // print('object OBJETO $atWork');
  // // final db = FirebaseFirestore.instance;
  // print("he entrado");
  // StreamBuilder(
  //   stream: db.doc(userPath).snapshots(),
  //   builder: (BuildContext context,
  //       AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
  // if (snapshot.hasError) {
  //   return ErrorWidget(snapshot.error.toString());
  // }
  // if (!snapshot.hasData) {
  //   return const CircularProgressIndicator();
  // }

  //     final doc = snapshot.data!;
  //     valorInicialAtwork = doc['atWork'];
  //     atWork = valorInicialAtwork;
  //     print('Atwork DENTRO DE GLOBALES VALE $valorInicialAtwork');
  //     return Text("data");
  //   },
  // );

  // return valorInicialAtwork;
//}

// @override
// void initState() {
//   final db = FirebaseFirestore.instance;
//   myStream = db.doc(userPath).snapshots().listen((snapshot) =>
//       atWork = snapshot.data()?['atWork'] ?? false);
//   super.initState();
// }

// @override
// void dispose() {
//   myStream.cancel();
//   super.dispose();
// }
