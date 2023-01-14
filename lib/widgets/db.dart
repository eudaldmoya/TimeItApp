import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeitapp/model/User_work.dart';
import 'package:timeitapp/model/dia.dart';
import 'package:timeitapp/model/group_days.dart';
import 'package:timeitapp/model/message.dart';

Stream<List<Message>> getGroupMessages() {
  return FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/Chat/qkKJ8H4tgmldDRJInX4T/messages')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map(toMessageList);
}

Future<void> sendMessage(Message msg) async {
  await FirebaseFirestore.instance
      .collection(
          '/Company/kGCOpHgRyiIYLr4Fwuys/Chat/qkKJ8H4tgmldDRJInX4T/messages')
      .add(msg.toFirestore());
}

Stream<List<Jornada>> GetWorkingDays() {
  return FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map(toJornadaList);
}

Stream<List<ColeccionJornadas>> GetColWork() {
  return FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
      .orderBy('workingDate', descending: true)
      .snapshots()
      .map(toColeccionJornadasList);
}

Future<void> sendWorkDay(ColeccionJornadas jrn) async {
  await FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays')
      .add(jrn.toFirestore());
}

Future<void> sendUser(UserWork jrn, doc) async {
  await FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${doc}')
      .add(jrn.toFirestore());
}

Future<void> sendWorkDaynNO(Jornada jrn, day) async {
  await FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${day}')
      .add(jrn.toFirestore());
}

Future<void> createRoom(collection) async {
  await FirebaseFirestore.instance.collection(collection);

  // simply add a document in messages sub-collection when needed.
}

Stream<List<UserWork>> GetUsersWorkCol(documento) {
  return FirebaseFirestore.instance
      .collection('/Company/kGCOpHgRyiIYLr4Fwuys/WorkingDays/${documento}')
      .snapshots()
      .map(toUserWorkList);
}
