import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkersWorking {
  String id;
  bool exist;
 

  WorkersWorking.fromFirestore(DocumentSnapshot doc)
      : id = 'quieroquetengaestaid',
        exist = doc['exist'];
        

  Map<String, dynamic> toFirestore() => {
       
        
        'exist' : exist,
      };

WorkersWorking()
      : exist = true,
        id =
            FirebaseAuth.instance.currentUser!.uid; //NO ENTIENDO PORQUE NECESITA EL ID SI LUEGO PONE LO QUE EL QUIERE EN EL FIRESTORE
            
 

}

List<WorkersWorking> toWorkersWorkingList(QuerySnapshot query) {
  return query.docs.map((doc) => WorkersWorking.fromFirestore(doc)).toList();
}
