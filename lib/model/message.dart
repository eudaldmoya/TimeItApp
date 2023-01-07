import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id, text;
  DateTime datetime;

  Message.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        text = doc['text'],
        datetime = (doc['datetime'] as Timestamp).toDate();

  Map<String, dynamic> toFirestore() => {
        'text': text,
        'datetime': datetime,
      };

  Message(this.text)
      : datetime = DateTime.now(),
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE


  String get hhmm => '${datetime.hour.toString().padLeft(2,'0')}:${datetime.minute.toString().padLeft(2,'0')}';

}

List<Message> toMessageList(QuerySnapshot query) {
  return query.docs.map((doc) => Message.fromFirestore(doc)).toList();
}
