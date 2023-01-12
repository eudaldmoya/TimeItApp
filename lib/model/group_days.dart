import 'package:cloud_firestore/cloud_firestore.dart';

class ColeccionJornadas {
  String id;
  DateTime workingDate;

  ColeccionJornadas.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
       
        workingDate = (doc['datetime'] as Timestamp).toDate();
        

  Map<String, dynamic> toFirestore() => {
        
        'workingDate': workingDate,
        
      };

  ColeccionJornadas()
      : workingDate = DateTime.now(),
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE
            


  String get hhmm => '${workingDate.hour.toString().padLeft(2,'0')}:${workingDate.minute.toString().padLeft(2,'0')}';

}


List<ColeccionJornadas> toColeccionJornadasList(QuerySnapshot query) {
  return query.docs.map((doc) => ColeccionJornadas.fromFirestore(doc)).toList();
}
