import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

final iddoc = getRandomString(20);

final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

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
            'ix'; 
  String get ddmmyy =>
      '${workingDate.day.toString()}-${workingDate.month.toString()}-${workingDate.year.toString()}';

  String get iddoc => '${id.toString()}';
}

List<ColeccionJornadas> toColeccionJornadasList(QuerySnapshot query) {
  return query.docs.map((doc) => ColeccionJornadas.fromFirestore(doc)).toList();
}
