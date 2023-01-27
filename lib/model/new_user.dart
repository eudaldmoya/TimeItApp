import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id, dni, firstSurname, name, photoPath, secondSurname;
  bool admin, atWork;
  int priceHour;

  User.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        dni = doc['dni'],
        firstSurname = doc['firstSurname'],
        name = doc['name'],
        photoPath = doc['photoPath'],
        secondSurname = doc['secondSurname'],
        admin = doc['admin'],
        atWork = doc['atWork'],
        priceHour = doc['priceHour'];
        

  // Map<String, dynamic> toFirestore() => {

  //       'dni': dni,
  //       'firstSurname': firstSurname,
  //       'name' : name,
  //       'photoPath': '',
  //       'secondSurname': secondSurname,
  //       'admin' : admin,
        
  //       'atWork': atWork,
  //       'priceHour' : priceHour,

  //     };

  // User(this.text, this.userId)
  //     : datetime = DateTime.now(),
  //       id =
  //           'id'; 
            


  // String get hhmm => '${datetime.hour.toString().padLeft(2,'0')}:${datetime.minute.toString().padLeft(2,'0')}';

}

List<User> toUserList(QuerySnapshot query) {
  return query.docs.map((doc) => User.fromFirestore(doc)).toList();
}
