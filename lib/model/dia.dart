import 'package:cloud_firestore/cloud_firestore.dart';

class Jornada {
  String id, userId;
  DateTime datetime;

  Jornada.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
       
        datetime = (doc['datetime'] as Timestamp).toDate(),
        userId = doc['userId'];

  Map<String, dynamic> toFirestore() => {
        
        'datetime': datetime,
        'userId' : userId,
      };

  Jornada( this.userId)
      : datetime = DateTime.now(),
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE
            


  String get hhmm => '${datetime.hour.toString().padLeft(2,'0')}:${datetime.minute.toString().padLeft(2,'0')}';

}


List<Jornada> toJornadaList(QuerySnapshot query) {
  return query.docs.map((doc) => Jornada.fromFirestore(doc)).toList();
}
