import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/widgets/db.dart' as work;
import 'dart:math';


final iddoc = getRandomString(20);

final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));




class ColeccionJornadas {
  String id;
  DateTime workingDate;

  ColeccionJornadas.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        workingDate = (doc['workingDate'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() => {
        'workingDate': workingDate,
      };

  ColeccionJornadas()
      : workingDate = DateTime.now(),
        id = 'ix'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE

  String get ddmmyy =>
      '${workingDate.day.toString()}-${workingDate.month.toString()}-${workingDate.year.toString()}';

  String get iddoc => '${id.toString()}';
}





List<ColeccionJornadas> toColeccionJornadasList(QuerySnapshot query) {
  return query.docs.map((doc) => ColeccionJornadas.fromFirestore(doc)).toList();
}

// Future<void> crearWorkerColeccion() async {
//   final datos = ColeccionJornadas();
//   await FirebaseFirestore.instance
//       .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
//       .doc(datos.id)
//       .collection('trabajadores')
//       .doc(FirebaseAuth.instance.currentUser!.toString())
//       .collection('jornadas');
// }
