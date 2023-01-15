import 'package:cloud_firestore/cloud_firestore.dart';

class Jornada {
  String id;
  DateTime  startTime;
  bool finished;

  Jornada.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
       finished = false,
        //finishTime = (doc['datetime'] as Timestamp).toDate(),
         startTime = (doc['datetime'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() => {
        'finished' : finished,
       // 'finishTime': finishTime,
        'startTime': startTime,
      };

  Jornada()
      : //finishTime = DateTime.now(),
        startTime = DateTime.now(),
        finished = false,
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE
            


  String get hhmm => '${startTime.hour.toString().padLeft(2,'0')}:${startTime.minute.toString().padLeft(2,'0')}';

}


List<Jornada> toJornadaList(QuerySnapshot query) {
  return query.docs.map((doc) => Jornada.fromFirestore(doc)).toList();
}
