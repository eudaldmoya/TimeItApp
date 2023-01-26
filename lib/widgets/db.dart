import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/model/message.dart';
import 'package:timeitapp/model/workers_work.dart';

Stream<List<Message>> getGroupMessages() {
  return FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/Chat/qkKJ8H4tgmldDRJInX4T/messages')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map(toMessageList);
}

Future<void> sendMessage(Message msg) async {
  await FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/Chat/qkKJ8H4tgmldDRJInX4T/messages')
      .add(msg.toFirestore());
}



Stream<List<ColeccionJornadas>> GetColWork() {
  return FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
      .orderBy('workingDate', descending: true)
      .snapshots()
      .map(toColeccionJornadasList);
}

Future<void> sendWorkDay(ColeccionJornadas jrn) async {
  await FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
      .add(jrn.toFirestore());
}

Future<void> crearWorkerColeccion(WorkersWorking wrk, iddeldocumento) async {
  print('DENTRO ${FirebaseAuth.instance.currentUser!.uid}');
  final String documento = iddeldocumento;
  final docUser = FirebaseFirestore.instance
      .collection('Company')
      .doc('kGCOpHgRyiIYLr4Fwuys')
      .collection('WorkingDays')
      .doc(documento)
      .collection('trabajadores')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'exist': true,
  };

  docUser.set(json);
}



Stream<List<Jornada>> GetJornadas(idDia) {
  return FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${idDia}/trabajadores/${FirebaseAuth.instance.currentUser!.uid}/jornadas')
      .orderBy('startTime', descending: true)
      .snapshots()
      .map(toJornadaList);
}

Future<void> sendJordadaUser(Jornada jrnuser, idDia) async {
  await FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${idDia}/trabajadores/${FirebaseAuth.instance.currentUser!.uid}/jornadas')
      .add(jrnuser.toFirestore());
}

Future<void> finishedJornada(iddeldocumentodia, iddeldocumentojornada) async {
  
  final String documentodia = iddeldocumentodia;
  final String documentojornada = iddeldocumentojornada;
  print('DELDIA $iddeldocumentodia');
  print('DELDIA NO $documentojornada');
  final docUser = FirebaseFirestore.instance
      .collection('Company')
      .doc('kGCOpHgRyiIYLr4Fwuys')
      .collection('WorkingDays')
      .doc(documentodia)
      .collection('trabajadores')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('jornadas')
      .doc(documentojornada);

  final json = {
    'finishTime': DateTime.now(),
  };

  docUser.set(json, SetOptions(merge: true),);
  docUser.update({'finished':true});


}


