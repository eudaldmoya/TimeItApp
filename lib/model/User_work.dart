import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserWork {
  String id;
  DateTime workingDate;

  UserWork.fromFirestore(DocumentSnapshot doc)
      : id = FirebaseAuth.instance.currentUser!.toString(),
       
        workingDate = (doc['workingDate'] as Timestamp).toDate();
        

  Map<String, dynamic> toFirestore() => {
        
        'workingDate': workingDate,
        
      };

  UserWork()
      : workingDate = DateTime.now(),
        id =
            'id'; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE
            


  String get ddmmyy => '${workingDate.day.toString()}-${workingDate.month.toString()}-${workingDate.year.toString()}';

}


List<UserWork> toUserWorkList(QuerySnapshot query) {
  return query.docs.map((doc) => UserWork.fromFirestore(doc)).toList();
}
