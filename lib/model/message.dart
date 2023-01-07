import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  String id, text, userId;
  DateTime datetime;


  Message.fromFirestore(DocumentSnapshot doc)
  : id = doc.id, 
  text= doc['text'],
  datetime = (doc['datetime'] as Timestamp).toDate(),
  userId = 'hola';
}

List<Message> toMessageList(QuerySnapshot query){
  return query.docs.map((doc) => Message.fromFirestore(doc)).toList();
}