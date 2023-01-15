import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserWork {
  String id;
  
  

  UserWork.fromFirestore(DocumentSnapshot doc)
      : id = FirebaseAuth.instance.currentUser!.toString();
       
       
 
}


List<UserWork> toUserWorkList(QuerySnapshot query) {
  return query.docs.map((doc) => UserWork.fromFirestore(doc)).toList();
}
