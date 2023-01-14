import 'package:cloud_firestore/cloud_firestore.dart';

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
            


  String get ddmmyy => '${workingDate.day.toString()}-${workingDate.month.toString()}-${workingDate.year.toString()}';

}


List<ColeccionJornadas> toColeccionJornadasList(QuerySnapshot query) {
  return query.docs.map((doc) => ColeccionJornadas.fromFirestore(doc)).toList();
}
