import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeitapp/model/message.dart';

Stream<List<Message>> getGroupMessages() {
  return FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/Chat/qkKJ8H4tgmldDRJInX4T/messages')
      .snapshots()
      .map(toMessageList);
}
