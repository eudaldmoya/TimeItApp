import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/widgets/db.dart' as work;

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
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE

  String get ddmmyy =>
      '${workingDate.day.toString()}-${workingDate.month.toString()}-${workingDate.year.toString()}';
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
