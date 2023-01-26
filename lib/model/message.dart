import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id, text, userId;
  DateTime datetime;

  Message.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        text = doc['text'],
        datetime = (doc['datetime'] as Timestamp).toDate(),
        userId = doc['userId'];

  Map<String, dynamic> toFirestore() => {
        'text': text,
        'datetime': datetime,
        'userId' : userId,
      };

  Message(this.text, this.userId)
      : datetime = DateTime.now(),
        id =
            'id'; 
            


  String get hhmm => '${datetime.hour.toString().padLeft(2,'0')}:${datetime.minute.toString().padLeft(2,'0')}';

}

List<Message> toMessageList(QuerySnapshot query) {
  return query.docs.map((doc) => Message.fromFirestore(doc)).toList();
}
